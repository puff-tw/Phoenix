class TotalSalesSummaryController < ApplicationController

  skip_before_action :verify_authenticity_token

  def total_sales_summary
  end

  def show
    @products = Product.all.where('active' => true).order('sku');
    @location = BusinessEntity
                    .joins(:locations)
                    .select('business_entity_locations.id,
                             business_entities.alias_name,
                             business_entity_locations.name')
                    .where('business_entities.id = business_entity_locations.business_entity_id and business_entity_locations.active = TRUE')

    @stock_summary = Array.new
    @language = Language.all.where('active = true');

  end

  def pos_products
    @products = Product.all.where('active=true').order('sku');
  end

  # SELECT
  # business_entity_locations.id,
  #     business_entities.alias_name,
  #     business_entity_locations.name
  # FROM business_entity_locations, business_entities
  # WHERE business_entities.id = business_entity_locations.business_entity_id
  # AND business_entity_locations.active = TRUE

  def constructdatatable

    filter_params = Hash.new
    filter_params[:location_id] = params[:location_id]
    filter_params[:product_id] = params[:product_id]
    filter_params[:language_id] = params[:language_id]
    filter_params[:from_date] = params[:from_date] || '01/04/2015'

    if (params[:to_date]=='')
      filter_params[:to_date] = Time.zone.now.strftime('%d/%m/%Y')
    else
      filter_params[:to_date] = params[:to_date]
    end

    @stock_summary = LanguageReport.locationwise_stock_summary_table({}, filter_params)

    respond_to do |format|
      format.xls { send_data LanguageReport.locationwise_stock_summary({col_sep: "\t"}, filter_params), filename: "total_sales_summary_#{Time.zone.now.in_time_zone.strftime('%Y%m%d')}.xls" }
      format.html
    end
  end

  def validate_negative_sales

    #parsed_json = J(params[:data])

    h = JSON.parse params[:data]
    location = h['location']


    r = ""
    sku = ""
    a=[]
    h['items'].each do |child|
      r = Product.find(child['sku'])['sku']
      q = child['quantity']
      sku = r

      filter_params = Hash.new
      filter_params[:language_id] = location
      filter_params[:from_date] = params[:from_date] || '01/04/2015'
      filter_params[:to_date] = params[:to_date] || Time.zone.now.strftime('%d/%m/%Y')
      filter_params[:sku] = sku
      filter_params[:quantity] = q.to_i
      available_stock = TotalStockCalculation.locationwise_stock_summary({}, filter_params)

      a.push(available_stock)
    end


    respond_to do |format|
      format.json { render json: a, status: :ok }
    end
  end

  #showing sales limit screen
  def show_limit

    @location = BusinessEntity
                    .joins(:locations)
                    .select('business_entity_locations.id,
                                        business_entities.alias_name,
                                        business_entity_locations.name')
                    .where('business_entities.id = business_entity_locations.business_entity_id and business_entity_locations.active = TRUE')


  end

  def pos_display

  end


  #calculates sales limit
  def calculate_sales_limit
    filter_params = Hash.new
    filter_params[:location_id] = params[:location_id]
    filter_params[:limit] = params[:limit]
    filter_params[:from_date] = params[:from_date] || '01/04/2015'
    filter_params[:to_date] = params[:to_date] || Time.zone.now.strftime('%d/%m/%Y')

    @sales_result = TotalStockCalculation.calculate_sales({}, filter_params)
  end


  #creates new account with cash accounts
  def create_user_with_account

    name = params[:name]
    idcard = params[:idcard]
    mobile = params[:mobile]
    role = params[:role]

    begin

      user = User.create!(
          name: name,
          city_id: 1,
          email: idcard+'@kanha.org',
          contact_number_primary: mobile,
          active: true,
          membership_number: idcard
      )

      userrole = UserRole.create!(
          user: user,
          role_id: role.to_i,
          business_entity_location_id: GlobalSettings.current_bookstall_id,
          active: true
      )
      account = Account::CashAccount.create!(
          business_entity_id: GlobalSettings.current_business_entitry_id,
          name: "Cash_#{user.id}",
          alias_name: "Cash - #{user.name}",
          reserved: true
      )
      user.update_attributes!(cash_account_id: account.id)
      user.update_attributes!(password: idcard, password_confirmation: idcard)

      redirect_to :create_user, flash: {success: "User Created Succesfully..."}
    rescue
      redirect_to :create_user, flash: {status: "Failed to Create user..."}
    end
  end

  #route for stock reconsilation screen
  def stock_reconciliation
    @location = BusinessEntity
                    .joins(:locations)
                    .select('business_entity_locations.id,
                             business_entities.alias_name,
                             business_entity_locations.name')
                    .where('business_entities.id = business_entity_locations.business_entity_id and business_entity_locations.active = TRUE')

  end

  #createuser page route
  #displays only  the page
  def create_user

    # For displaying Roles dropdown in the create user page
    @roles = Role.all().where(:active => true)

  end

  def list_user
    @users = User
                 .joins(:roles)
                 .joins(:cash_account)
                 .select('users.id,users.name,users.email,roles.name as role,accounts.name as accname,accounts.alias_name,users.active')

  end


  #make user active
  #make account active
  def active_user

    id = params[:id]

    user = User.find(id)
    user.update(:active => true);
    Account::CashAccount.find(user.cash_account_id).update(:active => true);

    redirect_to :list_user, flash: {success: "User activated Succesfully..."}

  end

  #make user deactive
  #make account deactive
  def deactive_user

    id = params[:id]

    user = User.find(id)
    user.update(:active => false);
    Account::CashAccount.find(user.cash_account_id).update(:active => false);

    redirect_to :list_user, flash: {success: "User deactivated Succesfully..."}
  end

  #displays whole stock based on language order in pdf
  def stock_pdf
    filter_params = Hash.new
    filter_params[:location_id] = GlobalSettings.current_bookstall_id
    @stock = StockReconciliationReport.locationwise_stock_summary_table({}, filter_params)
    respond_to do |format|
      format.html
      format.pdf do
        pdf = StockReconciliationPdf.new(@stock)
        send_data pdf.render, filename: "payment_collection_report",
                  type: "application/pdf",
                  disposition: 'inline'
      end
    end
  end
end

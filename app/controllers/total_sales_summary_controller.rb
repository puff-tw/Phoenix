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


  #510312205001
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
    filter_params[:location_id] = params[:location_id]
    @stock = StockReconciliationReport.locationwise_stock_summary_table({}, filter_params)

    @arrs = @stock.dup
    output_hash = Hash.new

    result = Hash.new


    uniq_values = @stock.uniq { |e| e['Lang'] }



    uniq_values.each do |lang|
      output_hash[lang['Lang']] = @arrs.select { |arrs| arrs["Lang"].to_s == lang['Lang'] }
    end


    result['products'] =output_hash
    result['location'] = BusinessEntityLocation.find(params[:location_id].to_i).name


    respond_to do |format|
      format.html
      format.pdf do
        pdf = StockReconciliationPdf.new(result)
        send_data pdf.render, filename: "payment_collection_report",
                  type: "application/pdf",
                  disposition: 'inline'
      end
    end
  end

  def invoice_list_with_payment

    @report = PosInvoicesReport.invoice_list_with_payments()

  end


  def line_item_extract
    @report = PosInvoicesReport.pos_invoice_line_items();
  end


  def voucher_line_item_extract
    @report = InventoryTxnVouchersReport.inventory_internal_transfer_vouchers_line_items()

    voucher_type = @report.map { |x| x['VoucherType'] }
    @uniq_vucher = voucher_type.uniq
  end

  def sku_lookup

    @skulookup = cal_sku_lookup

    arr = ""
  end

  def cal_sku_lookup

    filter_params = Hash.new
    filter_params[:location_id] = GlobalSettings.current_bookstall_id
    filter_params[:from_date] = params[:from_date] || GlobalSettings.start_date
    filter_params[:to_date] = params[:to_date] || Time.zone.now.strftime('%d/%m/%Y')

    result = Array.new

    @available_stock = TotalStockCalculation.calculate_sales_without_limit({}, filter_params)
    @threshold=Threshold.all

    @available_stock.each do |available_stock|
      @threshold.each do |threshold|
        if threshold.sku.to_i == available_stock['Sku'].to_i
          if threshold.threshold_val > available_stock['AvailableStock']
            myHash = available_stock
            myHash['Limit'] = threshold.threshold_val
            result << myHash
          end
        end
      end
    end

    result
  end


  def edit_threshold

    @category = Category.where(:active => true)
    @language = Language.where(:active => true)
    @products = Product.includes(:language).where(:active => true)
  end

  def save_threshold

    product_sku = params[:product]
    category_id = params[:category]
    language_id = params[:language]
    thershold_value = params[:thresholdvalue].to_i


    success_value=""

    if (product_sku=="")
      if category_id==""
        obj = ThresholdCapture.new(:language_id => language_id.to_i, :threshold_value => thershold_value)
        obj.save
      else
        obj = ThresholdCapture.new(:category_id => category_id.to_i, :threshold_value => thershold_value)
        obj.save
      end
    else
      obj = ThresholdCapture.new(:product_sku => product_sku.to_i, :threshold_value => thershold_value)
      obj.save
    end


    init_threshold

    redirect_to :sku_lookup, flash: {success: "Threshold limit made succesfully..."}
  end


  def init_threshold
    Threshold.delete_all
    @products = Product.all


    #inserting products from products table
    Threshold.connection.insert('INSERT INTO thresholds (sku,created_at,updated_at)
                                        SELECT sku,current_timestamp,current_timestamp
                                        FROM products where active=true')

    @threshold = ThresholdCapture.all
    @threshold.each do |threshold|

      if threshold.category_id !=0
        #category
        @prod = Product.where(:category_id => threshold.category_id)
        @prod.each do |prod|
          thersh = Threshold.where(:sku => prod.sku).update_all(threshold_val: threshold.threshold_value)
        end
      end

      if threshold.language_id !=0
        #language
        @prod = Product.where(:language_id => threshold.language_id)
        @prod.each do |prod|
          thersh = Threshold.where(:sku => prod.sku).update_all(threshold_val: threshold.threshold_value)
        end
      end

      if threshold.product_sku !=0
        #product
        @prod = Product.where(:sku => threshold.product_sku)
        @prod.each do |prod|
          thersh = Threshold.where(:sku => prod.sku).update_all(threshold_val: threshold.threshold_value)
          # thersh.save
        end
      end
    end
  end

  def view_threshold

    @threshold = ThresholdCapture.all
  end

  def edit_element_threshold
    id = params[:id]
    @threshold = ThresholdCapture.find(id.to_i)
  end

  def delete_element_threshold
    id = params[:id]
    ThresholdCapture.find(id.to_i).delete
    init_threshold

    redirect_to :view_threshold, flash: {warning: "Threshold deleted succesfully..."}
  end

  def save_element_threshold
    id = params[:threshold_id]
    value = params[:newthreshold]
    ThresholdCapture.find(id.to_i).update!(:threshold_value => value.to_i)

    init_threshold
    redirect_to :view_threshold, flash: {success: "Threshold Value Updated succesfully..."}
  end

  def pdf_merger_in

    jsonData = params[:hiddenjson]

    respond_to do |format|
      format.html
      format.pdf do
        pdf = InventoryInVoucherPdf.new(jsonData)
        send_data pdf.render, filename: "inventory_in_report",
                  type: "application/pdf",
                  disposition: 'inline'
      end
    end
  end

  def pdf_merger_out

    jsonData = params[:hiddenjson]

    respond_to do |format|
      format.html
      format.pdf do
        pdf = InventoryOutVoucherPdf.new(jsonData)
        send_data pdf.render, filename: "inventory_out_report",
                  type: "application/pdf",
                  disposition: 'inline'
      end
    end
  end

  def pdf_merger_in_transfer

    jsonData = params[:hiddenjson]

    respond_to do |format|
      format.html
      format.pdf do
        pdf = InventoryInternalTransferVoucherPdf.new(jsonData)
        send_data pdf.render, filename: "inventory_internal_transfer",
                  type: "application/pdf",
                  disposition: 'inline'
      end
    end
  end

  def dc_report

  end

  def with_amount_dcreport
    filter_params = Hash.new
    filter_params[:location_id] = 160
    stock = DCReport.locationwise_stock_summary({}, filter_params)


    respond_to do |format|
      format.html
      format.pdf do
        pdf = DcReportWithAmountPdf.new(stock)
        send_data pdf.render, filename: "inventory_internal_transfer",
                  type: "application/pdf",
                  disposition: 'inline'
      end
    end

  end

  def without_amount_dcreport


    filter_params = Hash.new
    filter_params[:location_id] = 160
    stock = DCReport.locationwise_stock_summary({}, filter_params)


    respond_to do |format|
      format.html
      format.pdf do
        pdf = DcReportWithoutAmountPdf.new(stock)
        send_data pdf.render, filename: "inventory_internal_transfer",
                  type: "application/pdf",
                  disposition: 'inline'
      end
    end
  end
end

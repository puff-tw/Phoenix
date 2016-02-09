class TotalSalesSummaryController < ApplicationController
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

    # show

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
  def show_limit
    
    @location = BusinessEntity
                    .joins(:locations)
                    .select('business_entity_locations.id,
                                        business_entities.alias_name,
                                        business_entity_locations.name')
                    .where('business_entities.id = business_entity_locations.business_entity_id and business_entity_locations.active = TRUE')

  end

  def calculate_sales_limit
    filter_params = Hash.new
    filter_params[:location_id] = params[:location_id]
    filter_params[:limit] = params[:limit]
    filter_params[:from_date] = params[:from_date] || '01/04/2015'
    filter_params[:to_date] = params[:to_date] || Time.zone.now.strftime('%d/%m/%Y')
    
    @sales_result = TotalStockCalculation.calculate_sales({},filter_params)
  end

end

class OnHandLookUpController < ApplicationController
  def show

    @location = BusinessEntity
                    .joins(:locations)
                    .select('business_entity_locations.id,
                              business_entities.alias_name,
                              business_entity_locations.name')
                    .where('business_entities.id = business_entity_locations.business_entity_id', 'business_entity_locations.active = TRUE')
    @products = Product.all.where('active' => true).order('sku');
  end
  
  def calculate
    filter_params = Hash.new
    filter_params[:location_id] = params[:location_id]
    filter_params[:product_id] = params[:product_id]
    filter_params[:from_date] = params[:from_date] || '01/04/2015'
    filter_params[:to_date] = Time.zone.now.strftime('%d/%m/%Y')

    @stock_summary = LookupReport.locationwise_stock_summary({}, filter_params)

    respond_to do |format|
      format.xls { send_data LookupReport.locationwise_stock_summary({col_sep: "\t"}, filter_params), filename: "on_hand_lookup_summary_#{params[:location_id]}_#{Time.zone.now.in_time_zone.strftime('%Y%m%d')}.xls" }
      format.html
    end
  end
end
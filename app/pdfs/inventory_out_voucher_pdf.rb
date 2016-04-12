class InventoryOutVoucherPdf < Prawn::Document

  def initialize(inventory_in_voucher)
    super({top_margin: 20, left_margin: 35, right_margin: 25, bottom_margin: 20})
    @inventory_out = inventory_in_voucher
    text GlobalSettings.organisation_name, size: 15, style: :bold, align: :center
    move_down 10
    generated_date
    stroke_horizontal_rule
    move_down 10
    line_items
  end

  def generated_date
    move_down 10
    text "Generated at: #{ Time.zone.now.to_formatted_s(:long) }", size: 12
  end
  def line_items
    table fetch_records do
      row(0).font_style = :bold
      columns(0).align = :center
      columns(0).width = 80
      columns(1).align = :left
      columns(1).width = 60
      columns(2..3).align = :center
      columns(2).width = 70
      columns(3).width = 75
      column(4).align = :right
      columns(4).width = 80
      column(5).align = :center
      columns(5).width = 115
      column(6).align = :center
      columns(6).width = 80
      row(0).align = :center
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.width = 560
      self.cell_style = {size: 10, padding_left: 10, padding_right: 10}
      self.header = true
    end
  end

  def fetch_records
    result = [['Date', "Invoice", "Consignor::Location", "Consingee Entity", "Amount", "Remarks", "CreatedBy"]]
    @inventory_out.each do |inventory_out_voucher|
      result += [[
                     inventory_out_voucher.voucher_date.strftime('%d/%m/%Y'),
                     inventory_out_voucher.voucher_number,
                     inventory_out_voucher.primary_entity_name_with_location,
                     inventory_out_voucher.secondary_entity_alias_name,
                     inventory_out_voucher.total_amount,
                     inventory_out_voucher.remarks,
                     inventory_out_voucher.created_by.custom_object_label
                 ]]
    end
    result
  end

end
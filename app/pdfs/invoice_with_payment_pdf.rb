class InvoiceWithPaymentPdf < Prawn::Document

  def initialize(stock)
    super({top_margin: 20, left_margin: 35, right_margin: 25, bottom_margin: 20})
    @stock_location = stock
    line_items
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
    result = [['Date', "Invoice", "Vendor/Source", "Location", "Amount", "Remarks", "CreatedBy"]]
    @inventory_in.each do |inventory_in_voucher|
      result += [[
                     inventory_in_voucher.voucher_date.strftime('%d/%m/%Y'),
                     inventory_in_voucher.voucher_number,
                     inventory_in_voucher.secondary_entity_alias_name,
                     inventory_in_voucher.primary_entity_name_with_location,
                     inventory_in_voucher.total_amount,
                     inventory_in_voucher.remarks,
                     inventory_in_voucher.created_by.custom_object_label
                 ]]
    end
    result
  end
end
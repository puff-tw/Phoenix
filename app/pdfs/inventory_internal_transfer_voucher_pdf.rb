class InventoryInternalTransferVoucherPdf < Prawn::Document
  def initialize(inventory_internal_transfer_voucher)
    super({top_margin: 20, left_margin: 35, right_margin: 25, bottom_margin: 20})
    @inventory_internal_transfer_voucher = JSON.parse inventory_internal_transfer_voucher
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
    move_down 10
    table line_item_rows do
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

  def line_item_rows
    result = [['Date', "Invoice", "From Location", "To Location", "Amount", "Remarks", "CreatedBy"]]
    @inventory_internal_transfer_voucher.each do |inventory_internal_transfer_voucher|
      result += [[
                     inventory_internal_transfer_voucher['row1'],
                     inventory_internal_transfer_voucher['row2'],
                     inventory_internal_transfer_voucher['row3'],
                     inventory_internal_transfer_voucher['row4'],
                     inventory_internal_transfer_voucher['row5'],
                     inventory_internal_transfer_voucher['row6'],
                     inventory_internal_transfer_voucher['row7']
                 ]]
    end
    result
  end

end

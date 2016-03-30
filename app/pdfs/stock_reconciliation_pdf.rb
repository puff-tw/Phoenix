class StockReconciliationPdf < Prawn::Document

  def initialize(stock)
    super({top_margin: 20, left_margin: 35, right_margin: 25, bottom_margin: 20})
    @stock_location = stock.sort_by { |k| k['Lang']}
    line_items
  end

  def line_items
    table fetch_records do
      row(0).font_style = :bold
      columns(0).align = :center
      columns(0).width = 60
      columns(1).align = :left
      columns(1).width = 200
      columns(2..3).align = :center
      columns(2).width = 70
      columns(3).width = 75
      column(4).align = :right
      columns(4).width = 80
      column(5).align = :right
      columns(5).width = 75
      row(0).align = :center
      # self.row_colors = ["DDDDDD", "FFFFFF"]
      self.width = 560
      self.cell_style = { size: 12, padding_left: 10, padding_right: 10 }
      self.header = true
    end
  end

  def fetch_records
    result = [['SKU', "Product", "Location", "Category", "Language", "AvailableQuantity"]]
    @stock_location.each do |item|
      result += [[item['Sku'], item['ProductName'], item['Location'], item['PCat'], item['Lang'], item['AvailableStock']]]
    end
    result
  end
end
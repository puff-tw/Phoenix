class StockReconciliationPdf < Prawn::Document

  def initialize(stock)
    super({top_margin: 20, left_margin: 35, right_margin: 25, bottom_margin: 20})
    @stock_location = stock
    line_items
  end

  def line_items

    @stock_location.each do |stockitem|
      result = [['SKU', "Product", "Location", "Category", "Language", "AvailableQuantity"]]

      stockitem[1].each do |item|
        result += [[item['Sku'], item['ProductName'], item['Location'], item['PCat'], item['Lang'], item['AvailableStock']]]
      end


      text stockitem[0],size: 20, style: :bold, align: :center

      move_down(10)
      table result do
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
        self.cell_style = {size: 12, padding_left: 10, padding_right: 10}
        self.header = true
      end

      start_new_page
    end
  end

  # def fetch_records
  #
  #
  #   #@fathers.select {|father| father["age"] > 35 }
  #
  #   output_hash = Hash.new
  #   uniq_values = @stock_location.uniq! { |e| e['Lang'] }
  #
  #   uniq_values.each do |langkey|
  #     output_hash[langkey] = @stock_location.select { |lang| lang["Lang"].to_s == langkey.to_s }
  #   end
  #
  #   lang = ""
  #   result = [['SKU', "Product", "Location", "Category", "Language", "AvailableQuantity"]]
  #   @stock_location.each do |item|
  #     result += [[item['Sku'], item['ProductName'], item['Location'], item['PCat'], item['Lang'], item['AvailableStock']]]
  #   end
  #   result
  # end
end
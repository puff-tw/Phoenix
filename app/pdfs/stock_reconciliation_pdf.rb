class StockReconciliationPdf < Prawn::Document

  def initialize(stock)
    super({top_margin: 20, left_margin: 35, right_margin: 25, bottom_margin: 20})
    @stock_location = stock
    text GlobalSettings.organisation_name, size: 15, style: :bold, align: :center
    move_down 10
    generated_date
    stroke_horizontal_rule
    move_down 10
    line_items
    number_pages "<page> / <total>", { :start_count_at => 0, :page_filter => :all, :at => [bounds.right - 50, 0], :align => :center, :size => 14 }
  end
  def generated_date
    move_down 10
    text "Generated at: #{ Time.zone.now.to_formatted_s(:long) }", size: 12
  end

  def line_items

    @stock_location.each do |stockitem|
      result = [['SKU',  "Category", "Product", "Expected On-Hand Quantity","Actual On-Hand Quantity"]]

      location = ''
      stockitem[1].each do |item|
        result += [[item['Sku'], item['PCat'],  item['ProductName'], item['AvailableStock'],""]]
        location=item['Location']
      end


      text stockitem[0],size: 20, style: :bold, align: :center
      text location,size: 10, style: :bold, align: :right
      stroke_horizontal_rule

      move_down(10)
      table result do
        row(0).font_style = :bold
        columns(0).align = :center
        columns(0).width = 70
        columns(1).align = :center
        columns(1).width = 100
        columns(2).align = :left
        columns(2).width = 180
        column(3).align = :left
        columns(3).width = 100
        column(4).align = :center
        columns(4).width = 110
        row(0).align = :center
        self.row_colors = ["DDDDDD", "FFFFFF"]
        self.width = 560
        self.cell_style = {size: 10, padding_left: 5, padding_right: 5}
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
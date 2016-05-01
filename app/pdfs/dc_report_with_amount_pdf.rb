class DcReportWithAmountPdf < Prawn::Document
  def initialize(stock)
    super({top_margin: 20, left_margin: 35, right_margin: 25, bottom_margin: 20})
    @stock_location = stock


    @result = @stock_location.each_slice(25).to_a

    line_items
  end


  def line_items

    j = 1
    @result.each do |item|


      text 'TIN No: 36217061270',size: 8,align: :right
      text 'STOCK TRANSFER MEMO', size: 11, style: :bold, align: :center
      text 'SPIRITUAL HIERARCHY PUBLICATION TRUST', size: 14, style: :bold, align: :center
      text 'Kanha Shanti Vanam, Shri Ramchandra Mission,13-110, Chegur, Kothur, Mahoobnagar Dt, Telegana 509228', size: 10, style: :bold, align: :center

      move_down 10
      stroke_horizontal_rule
      move_down 10
      text 'To ',size:8,align: :left,style: :bold
      text 'Spiritual Hierarchy Publication Trust',size:8,align: :left
      text 'Admin Building, Babuji Memorial Ashram',size:8,align: :left
      text 'SRCM Road, Manapakkam, Chennai - 600125',size:8,align: :left
      text 'TIN: 334008454081,CST No. 985622 dt. 08.04.2009',size:8,align: :left

      #text_box data, :at=> [10, 100], :width=> 200, :height=> 50, :overflow=> :shrink_to_fit, :min_font_size=> 8
      text 'ST-CHE-'+j.to_s, size: 8, style: :bold, align: :right
      text Time.zone.now.strftime('%d/%m/%Y'), size: 8, style: :bold, align: :right


      result = [['S.No', "Code","Type", "Description", "Rate","Quantity", "Amount"]]
      i = 1
      item.each do |item1|
        price = (Product.select('selling_price').where(:sku => item1['Sku'].to_i).limit(1).pluck(:selling_price)[0].to_i)
        result += [[i,item1['Sku'], item1['PCat'], item1['ProductName'], price ,item1['AvailableStock'].abs, price * item1['AvailableStock'].to_i.abs]]
        i=i+1
      end


      table result do
        row(0).font_style = :bold
        columns(0).align = :center
        columns(0).width = 40
        columns(1).align = :center
        columns(1).width = 60
        columns(2).align = :left
        columns(2).width = 60
        column(3).align = :left
        columns(3).width = 160
        column(4).align = :center
        columns(4).width = 80
        column(5).align = :center
        columns(5).width = 80
        column(6).align = :center
        columns(6).width = 80
        row(0).align = :center
        self.row_colors = ["DDDDDD", "FFFFFF"]
        self.width = 560
        self.cell_style = {size: 8, padding_left: 3, padding_right: 3}
        self.header = true
      end

      j=j+1
      start_new_page
    end
  end
end
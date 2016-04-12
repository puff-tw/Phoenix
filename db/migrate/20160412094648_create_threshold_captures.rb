class CreateThresholdCaptures < ActiveRecord::Migration
  def change
    create_table :threshold_captures do |t|
      t.integer :category_id
      t.integer :language_id
      t.integer :product_sku
      t.integer :threshold_value
    end
  end
end

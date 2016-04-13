class CreateThresholdCaptures < ActiveRecord::Migration
  def change
    create_table :threshold_captures do |t|
      t.integer :category_id, default: 0
      t.integer :language_id, default: 0
      t.integer :product_sku, default: 0
      t.integer :threshold_value
    end
  end
end

class CreateThresholds < ActiveRecord::Migration
  def change
    create_table :thresholds do |t|
      t.integer :sku
      t.integer :threshold_val, default: GlobalSettings.threshold_default
      t.timestamps null: false
    end

  end
end

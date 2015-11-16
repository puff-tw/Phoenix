class ConvertAllFloatToDecimal < ActiveRecord::Migration
  def change
    change_column :inventory_txn_line_items, :amount, :decimal, precision: 10, scale: 2, null: false
    change_column :inventory_txn_line_items, :tax_amount, :decimal, precision: 10, scale: 2, null: false
    change_column :inventory_txn_line_items, :rate, :decimal, precision: 8, scale: 2, null: false
    rename_column :inventory_txn_line_items, :rate, :price
    change_column :inventory_txn_line_items, :tax_rate, :decimal, precision: 5, scale: 2, null: false

    change_column :inventory_txns, :total_amount, :decimal, precision: 10, scale: 2, null: false
    change_column :inventory_txns, :tax_amount, :decimal, precision: 10, scale: 2, null: false
    change_column :inventory_txns, :goods_value, :decimal, precision: 10, scale: 2, null: false
    remove_column :inventory_txns, :additional_charges, :decimal, precision: 10, scale: 2, null: false

    drop_table :pur_invoice_line_items
    drop_table :pur_invoice_payments
    drop_table :pur_invoices

    add_column :inventory_txn_line_items, :quantity_in, :integer
    rename_column :inventory_txn_line_items, :quantity, :quantity_out
    change_column_null(:inventory_txn_line_items, :quantity_out, true)
    execute "alter table inventory_txn_line_items ADD CONSTRAINT quantity_in_xor_quantity_out check(
      (quantity_in  IS NOT null)::integer +
      (quantity_out IS NOT null)::integer = 1
    );"
  end
end

class AccountsContinued < ActiveRecord::Migration
  def change
    rename_table :account_txn_details, :invoice_headers

    change_column_null(:account_txns, :txn_date, false)
    remove_column :account_entries, :order, :integer
    remove_column :account_entries, :active, :boolean
    add_column :invoice_headers, :business_entity_location_id, :integer, null: false
    add_index :invoice_headers, :business_entity_location_id
    add_foreign_key :invoice_headers, :business_entity_locations, on_delete: :cascade

    add_column :business_entity_locations, :cash_account_id, :integer
    add_index :business_entity_locations, :cash_account_id
    add_foreign_key :business_entity_locations, :accounts, column: :cash_account_id, primary_key: :id, on_delete: :restrict

    add_column :business_entity_locations, :bank_account_id, :integer
    add_index :business_entity_locations, :bank_account_id
    add_foreign_key :business_entity_locations, :accounts, column: :bank_account_id, primary_key: :id, on_delete: :restrict

    add_column :business_entity_locations, :sales_account_id, :integer
    add_index :business_entity_locations, :sales_account_id
    add_foreign_key :business_entity_locations, :accounts, column: :sales_account_id, primary_key: :id, on_delete: :restrict

    add_column :account_txn_line_items, :state_category_tax_rate_id, :integer
    add_index :account_txn_line_items, :state_category_tax_rate_id
    add_foreign_key :account_txn_line_items, :state_category_tax_rates, on_delete: :restrict

    add_index :invoice_headers, :account_txn_id, unique: true
  end
end

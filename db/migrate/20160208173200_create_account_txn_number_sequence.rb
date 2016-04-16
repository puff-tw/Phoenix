class CreateAccountTxnNumberSequence < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE SEQUENCE account_txns_number_seq;
    SQL
  end

  def down
    execute <<-SQL
      DROP SEQUENCE account_txns_number_seq;
    SQL
  end
end

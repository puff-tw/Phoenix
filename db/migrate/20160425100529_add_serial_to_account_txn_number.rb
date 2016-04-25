class AddSerialToAccountTxnNumber < ActiveRecord::Migration
  def change
    execute <<-SQL
      ALTER SEQUENCE account_txns_number_seq OWNED BY account_txns.number;
      ALTER TABLE account_txns ALTER COLUMN number SET DEFAULT nextval('account_txns_number_seq');
    SQL
  end

  def down
    execute <<-SQL
      ALTER SEQUENCE account_txns_number_seq OWNED BY NONE;
      ALTER TABLE account_txns ALTER COLUMN number SET NOT NULL;

    SQL
  end
end

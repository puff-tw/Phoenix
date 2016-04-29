module AccountEntriesExtension
  def debit_balance
    from = GlobalSettings.start_date.to_date.strftime("%d/%m/%Y-%H:%M:%S").to_datetime
    to = Date.today.end_of_day.strftime("%d/%m/%Y-%H:%M:%S").to_datetime

    where(type: 'AccountEntry::Debit').where(:created_at=>from..to).sum(:amount) - where(type: 'AccountEntry::Credit').where(:created_at=>from..to).sum(:amount)

  end

  def debit_detail
    from = GlobalSettings.start_date.to_date.strftime("%d/%m/%Y-%H:%M:%S").to_datetime
    to = Date.today.end_of_day.strftime("%d/%m/%Y-%H:%M:%S").to_datetime

    where(type: 'AccountEntry::Debit').where(:created_at=>from..to)
        .group("date(created_at)")
        .order('date_created_at')
        .sum(:amount)
  end


  def credit_detail
    from = GlobalSettings.start_date.to_date.strftime("%d/%m/%Y-%H:%M:%S").to_datetime
    to = Date.today.end_of_day.strftime("%d/%m/%Y-%H:%M:%S").to_datetime

    where(type: 'AccountEntry::Credit')
        .joins(:account_txn)
        .where("account_txns.type='JournalVoucher'")
        .where("account_txns.created_at"=>from..to)
        .group("date(account_txns.created_at)")
        .order('date_account_txns_created_at')
        .sum(:amount)
  end

  def card_detail
    from = GlobalSettings.start_date.to_date.strftime("%d/%m/%Y-%H:%M:%S").to_datetime
    to = Date.today.end_of_day.strftime("%d/%m/%Y-%H:%M:%S").to_datetime

    where("mode = ?", ['Account::BankAccount']).where(:created_at=>from..to)
        .where(:created_at => from..to)
        .group("date(created_at)")
        .order('date_created_at')
        .sum(:amount)
  end

  def full_due_amount
    where(type: 'AccountEntry::Credit').sum(:amount)
  end

  def credit_balance
    where("type='AccountEntry::Debit' and mode='Account::BankAccount'").sum(:amount)
  end

  def list_full_debit
    where(type: 'AccountEntry::Debit')
  end


  def total_amount
    reject(&:marked_for_destruction?).sum(&:amount)
  end

  def sales_entries
    reject(&:marked_for_destruction?).select { |x| is_sales_entry?(x.mode) }
  end

  def sales_total_amount
    sales_entries.sum(&:amount)
  end

  # Returns array with ActiveRecord objects
  def payment_entries
    reject(&:marked_for_destruction?).select { |x| is_payment?(x.mode) }
  end

  # Returns Hash
  def payment_account_types
    hsh = Hash.new
    payment_entries.map { |entry| hsh[entry.account_id] = entry.mode }
    hsh
  end

  def payment_account_types_humanize
    hsh = Hash.new
    payment_entries.each do |payment|
      hsh[payment.account_id] = 'Cash' and next if payment.mode == 'Account::CashAccount'
      hsh[payment.account_id] = 'Credit Card' and next if payment.mode == 'Account::BankAccount'
    end
    hsh
  end

  def is_payment?(account_type=nil)
    ['Account::CashAccount', 'Account::BankAccount'].include? account_type
  end

  def is_sales_entry?(account_type=nil)
    ['Account::SalesAccount'].include? account_type
  end
end

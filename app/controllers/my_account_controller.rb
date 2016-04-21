class MyAccountController < ApplicationController
  def show

    @debit = @current_user.cash_account.entries.debit_detail
    @credit = @current_user.cash_account.entries.credit_detail


    id=@current_user.cash_account.id
    @amount_given_to_cashier = AccountEntry
                                   .where(:mode => 'Account::BankAccount')
                                   .where(:type => 'AccountEntry::Debit')
                                   .where(:account_id => id)
                                   .order("created_at DESC")


    # SELECT *
    #     FROM account_entries
    # LEFT OUTER JOIN account_txns
    # ON account_txns.id = account_entries.account_txn_id
    # LEFT OUTER JOIN users
    # ON users.id = account_txns.created_by_id
    # WHERE mode = 'Account::BankAccount' AND account_entries.type = 'AccountEntry::Debit'
    # AND users.id = 1;

    @card = AccountEntry
              .joins(:account_txn => :created_by)
              .where(:mode => 'Account::BankAccount')
              .where(:type => 'AccountEntry::Debit')
              .where('users.id=?', @current_user.id)
              .group("date(account_entries.created_at)")
              .sum(:amount)


    allDates = Array.new
    @debit.each do |k, v|
      allDates << k
    end
    @credit.each do |k, v|
      allDates << k
    end

    @card.each do |k, v|
      allDates << k
    end


    @dates = allDates.uniq.sort { |x, y| y<=>x }


  end
end

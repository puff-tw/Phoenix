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

    allDates = Array.new
    @debit.each do |k, v|
      allDates << k
    end
    @credit.each do |k, v|
      allDates << k
    end


    @dates = allDates.uniq.sort


  end
end

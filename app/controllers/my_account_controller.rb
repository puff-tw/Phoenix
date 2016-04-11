class MyAccountController < ApplicationController
  def show

    id=@current_user.cash_account.id
    @amount_given_to_cashier = AccountEntry
                                   .where(:type => 'AccountEntry::Credit')
                                   .where(:account_id => id)
                                   .order("created_at DESC")
  end
end

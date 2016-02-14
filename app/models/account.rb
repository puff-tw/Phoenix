class Account < MyActiveRecord
  belongs_to :business_entity, inverse_of: :accounts
  has_many :entries, class_name: 'AccountEntry', extend: AccountEntriesExtension, inverse_of: :account, dependent: :restrict_with_exception

  validates :business_entity, presence: true
  validates :name, presence: true, length: { in: 3..100 }, uniqueness: {scope: :business_entity}
  validates :alias_name, length: { in: 3..25 }, presence: true, uniqueness: { scope: :business_entity }
  # validates :code, length: { is: 6 }, presence: true, uniqueness: {scope: :business_entity}
  validates :type, presence: true
  validates :contra, inclusion: { in: [true, false] }
  validates :reserved, inclusion: { in: [true, false] }
  validates :active, inclusion: { in: [true, false] }

  class_attribute :normal_credit_balance

  def self.cash_or_bank_type
    where("(type = 'Account::CashAccount' OR type = 'Account::BankAccount') AND active=true")
  end
end

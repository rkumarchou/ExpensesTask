class Expense < ApplicationRecord
  belongs_to :account

  validates :amount, :date, :description, presence: true
  validates :amount, numericality: { greater_than: 0, only_integer: true }

  before_save :check_account_balance

  private
  def check_account_balance
    if amount > account.balance(id || [])
      errors.add(:amount, 'Insufficient balance in account') and throw(:abort)
    end
  end
end

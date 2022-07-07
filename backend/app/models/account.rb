class Account < ApplicationRecord
  INITIAL_BALANCE = 1000.freeze

  has_many :expenses, dependent: :destroy

  validates :name, :number, presence: true
  validates :number, uniqueness: { message: "An account already exists with this Bank Account Number" }
  validates :number, numericality: { greater_than: 0, only_integer: true }

  before_create :set_initial_balance

  def as_json(options)
    super.merge({
      "balance" => balance
    })
  end

  def balance(not_include_expense_ids=[])
    initial_balance - expenses.where.not(id: not_include_expense_ids).sum(:amount)
  end

  private
  def set_initial_balance
    self.initial_balance = INITIAL_BALANCE
  end
end

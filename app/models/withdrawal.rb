class Withdrawal < ApplicationRecord
  belongs_to :user

  MAX_WITHDRAWAL_AMOUNT = 500

  validates :amount, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: MAX_WITHDRAWAL_AMOUNT }

  validate :user_has_sufficient_balance

  private

  def user_has_sufficient_balance
    if user.balance < amount
      errors.add(:amount, "exceeds your available balance")
    end
  end
end

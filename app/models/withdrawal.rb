class Withdrawal < ApplicationRecord
  belongs_to :user

validate :amount_within_balance
#validates :amount, numericality: { greater_than_or_equal_to: 100.00 }
#validates :status, inclusion: { in: %w[pending approved rejected] }

def amount_within_balance
  if amount.present? && amount > user.balance
    errors.add(:amount, "cannot exceed your current balance ($#{user.balance})")
  end
end 

end

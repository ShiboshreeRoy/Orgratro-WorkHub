class AddReferralBalanceToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :referral_balance, :decimal, precision: 16, scale: 8, default: 0.0, null: false
  end
end

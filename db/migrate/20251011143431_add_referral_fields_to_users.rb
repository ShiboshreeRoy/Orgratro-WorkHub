class AddReferralFieldsToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :referral_code, :string
    add_column :users, :referred_by, :string
    add_column :users, :wallet_balance, :decimal, precision: 10, scale: 6, default: 0.0
    add_column :users, :total_referrals, :integer, default: 0

    # Generate referral codes for existing users
    User.reset_column_information
    User.find_each do |user|
      user.update_column(:referral_code, SecureRandom.hex(6))
    end

    change_column_null :users, :referral_code, false
  end

  def down
    remove_column :users, :referral_code
    remove_column :users, :referred_by
    remove_column :users, :wallet_balance
    remove_column :users, :total_referrals
  end
end

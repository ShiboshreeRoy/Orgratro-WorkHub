class AddRoleAndBalanceToUsers < ActiveRecord::Migration[7.2]
  def change
    #add_column :users, :role, :integer, default: 0
    add_column :users, :balance, :decimal, precision: 24, scale: 12, default: 0.0
  end
end

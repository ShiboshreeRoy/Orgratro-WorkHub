class CreateReferrals < ActiveRecord::Migration[7.0]
  def change
    create_table :referrals do |t|
      t.references :referrer, null: false, foreign_key: { to_table: :users }
      t.references :referred_user, foreign_key: { to_table: :users }
      t.string :token, null: false
      t.string :invite_email
      t.decimal :reward_amount, precision: 16, scale: 8, null: false, default: "0.005"
      t.boolean :claimed, default: false, null: false
      t.timestamps
  end


    add_index :referrals, :token, unique: true
  end
end
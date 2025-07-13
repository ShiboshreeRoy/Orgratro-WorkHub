# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.2]
  def change
    # Only create users table if it doesn't exist
    unless table_exists?(:users)
      create_table :users do |t|
        t.string :email,              null: false, default: ""
        t.string :encrypted_password, null: false, default: ""

        t.string   :reset_password_token
        t.datetime :reset_password_sent_at

        t.datetime :remember_created_at

        t.timestamps null: false
      end
    end

    # Add indexes only if they don't exist
    add_index :users, :email, unique: true unless index_exists?(:users, :email)
    add_index :users, :reset_password_token, unique: true unless index_exists?(:users, :reset_password_token)
  end
end

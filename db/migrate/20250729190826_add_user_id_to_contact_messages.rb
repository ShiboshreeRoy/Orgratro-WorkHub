class AddUserIdToContactMessages < ActiveRecord::Migration[7.2]
  def change
    add_reference :contact_messages, :user, null: false, foreign_key: true
  end
end

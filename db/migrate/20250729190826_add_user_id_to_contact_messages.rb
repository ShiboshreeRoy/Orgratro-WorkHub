class AddUserIdToContactMessages < ActiveRecord::Migration[7.2]
  def change
    add_reference :contact_messages, :user, foreign_key: true, null: true
  end
end

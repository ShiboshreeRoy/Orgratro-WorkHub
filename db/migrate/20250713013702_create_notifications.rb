class CreateNotifications < ActiveRecord::Migration[7.2]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :message
      t.boolean :read
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateUserLinks < ActiveRecord::Migration[7.2]
  def change
    create_table :user_links do |t|
      t.references :user, null: false, foreign_key: true
      t.references :link, null: false, foreign_key: true

      t.timestamps
    end
  end
end

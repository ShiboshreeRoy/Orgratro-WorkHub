class CreateLinks < ActiveRecord::Migration[7.2]
  def change
    create_table :links do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :clicks_count, default: 0
      t.decimal :earnings, precision: 20, scale: 10, default: 0.0

      t.timestamps
    end

    add_index :links, :url, unique: true
  end
end

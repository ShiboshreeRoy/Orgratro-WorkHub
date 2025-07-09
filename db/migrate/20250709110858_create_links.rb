class CreateLinks < ActiveRecord::Migration[7.2]
  def change
    create_table :links do |t|
      t.string :url
      t.integer :total_clicks
      t.integer :user_id

      t.timestamps
    end
  end
end

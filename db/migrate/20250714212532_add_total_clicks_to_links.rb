class AddTotalClicksToLinks < ActiveRecord::Migration[7.2]
  def change
    add_column :links, :total_clicks, :integer, default: 0, null: false
  end
end

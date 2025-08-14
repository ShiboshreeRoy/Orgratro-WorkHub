class AddNameAndWpNumberToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :name, :string, null: false, default: ""
    add_column :users, :wp_number, :string, null: false, default: ""

  end
end

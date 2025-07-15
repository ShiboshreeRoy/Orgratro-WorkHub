class AddSuspendedToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :suspended, :boolean
  end
end

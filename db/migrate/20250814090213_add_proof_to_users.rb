class AddProofToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :proof, :string
  end
end

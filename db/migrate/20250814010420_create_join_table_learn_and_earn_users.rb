class CreateJoinTableLearnAndEarnUsers < ActiveRecord::Migration[7.2]
  def change
    create_join_table :learn_and_earns, :users do |t|
      # t.index [:learn_and_earn_id, :user_id]
      # t.index [:user_id, :learn_and_earn_id]
    end
  end
end

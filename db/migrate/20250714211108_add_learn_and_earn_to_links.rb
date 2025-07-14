class AddLearnAndEarnToLinks < ActiveRecord::Migration[7.2]
  def change
    add_reference :links, :learn_and_earn, foreign_key: true
  end
end

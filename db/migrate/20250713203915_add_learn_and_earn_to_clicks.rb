class AddLearnAndEarnToClicks < ActiveRecord::Migration[7.2]
  def change
    add_reference :clicks, :learn_and_earn, null: false, foreign_key: true
  end
end

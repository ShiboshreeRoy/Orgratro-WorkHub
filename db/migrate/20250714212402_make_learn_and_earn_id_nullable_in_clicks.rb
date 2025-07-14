class MakeLearnAndEarnIdNullableInClicks < ActiveRecord::Migration[7.2]
  def change
     change_column_null :clicks, :learn_and_earn_id, true
  end
end

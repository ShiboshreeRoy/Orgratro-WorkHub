class ChangeTitleNullableInLinks < ActiveRecord::Migration[7.2]
  def change
    change_column_null :links, :title, true
  end
end

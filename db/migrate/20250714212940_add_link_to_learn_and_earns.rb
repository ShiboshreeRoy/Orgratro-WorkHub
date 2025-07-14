class AddLinkToLearnAndEarns < ActiveRecord::Migration[7.2]
  def change
    add_reference :learn_and_earns, :link, foreign_key: true #rails db:rollback null: false

  end
end

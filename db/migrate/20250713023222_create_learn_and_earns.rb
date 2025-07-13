class CreateLearnAndEarns < ActiveRecord::Migration[7.2]
  def change
    create_table :learn_and_earns do |t|
      t.references :user, null: false, foreign_key: true
      t.string :link
      t.string :social_post
      t.string :proof
      t.string :status

      t.timestamps
    end
  end
end

class CreateUserTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :user_tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true
      t.text :proof
      t.boolean :approved

      t.timestamps
    end
  end
end

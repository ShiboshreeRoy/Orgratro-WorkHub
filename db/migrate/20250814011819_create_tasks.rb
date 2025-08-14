class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :task_type
      t.string :link
      t.text :description
      t.integer :admin_id

      t.timestamps
    end
  end
end

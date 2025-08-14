class Task < ApplicationRecord
  belongs_to :user
  has_many :user_tasks, dependent: :destroy
  has_many :users, through: :user_tasks
  

  TASK_TYPES = ["Click Link", "Watch Video", "Survey", "Other"]
end

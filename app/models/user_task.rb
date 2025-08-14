class UserTask < ApplicationRecord
  belongs_to :user
  belongs_to :task
  validates :proof, presence: true, on: :update
end

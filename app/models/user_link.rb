class UserLink < ApplicationRecord
  belongs_to :user
  belongs_to :link

  validates :link_id, uniqueness: { scope: :user_id }

end

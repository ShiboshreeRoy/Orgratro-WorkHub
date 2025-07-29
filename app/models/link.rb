class Link < ApplicationRecord
    belongs_to :user
    has_many :clicks, dependent: :destroy
    has_many :learn_and_earns, dependent: :destroy
  
    belongs_to :learn_and_earn, optional: true
    has_many :user_links
    has_many :viewed_by_users, through: :user_links, source: :user

    
end

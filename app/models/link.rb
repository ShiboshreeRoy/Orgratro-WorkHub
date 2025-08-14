class Link < ApplicationRecord
    belongs_to :user
    has_many :clicks, dependent: :destroy
    has_many :learn_and_earns, dependent: :destroy
    #has_many :file
    has_many_attached :files



    has_many :user_links, dependent: :nullify
  
    belongs_to :learn_and_earn, optional: true
    has_many :user_links
    has_many :viewed_by_users, through: :user_links, source: :user

    
end

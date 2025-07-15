class Link < ApplicationRecord
    belongs_to :user
    has_many :clicks, dependent: :destroy
    has_many :learn_and_earns, dependent: :destroy
  
    belongs_to :learn_and_earn, optional: true

  

    
end

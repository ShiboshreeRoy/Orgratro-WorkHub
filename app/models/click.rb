class Click < ApplicationRecord
  belongs_to :user
  belongs_to :link
  belongs_to :learn_and_earn, optional: true
  #belongs_to :learn_and_earn

end

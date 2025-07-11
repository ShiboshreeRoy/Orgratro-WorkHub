class Link < ApplicationRecord
    belongs_to :user
    has_many :clicks, dependent: :destroy
end

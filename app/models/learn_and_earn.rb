class LearnAndEarn < ApplicationRecord
  belongs_to :user
  
  has_many :clicks, dependent: :destroy
  has_many :links, dependent: :destroy

  attr_accessor :skip_proof_validation
  validates :link, presence: true
  validates :social_post, presence: true
  validates :proof, presence: true, unless: -> { skip_proof_validation }
  validates :status, inclusion: { in: ['pending', 'approved', 'rejected'] }

  before_validation :set_default_status, on: :create

  private

  def set_default_status
    self.status ||= 'pending'
  end
end

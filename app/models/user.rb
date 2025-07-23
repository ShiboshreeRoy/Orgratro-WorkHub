class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  enum role: { standard: 1, admin: 2 }

  has_many :clicks, dependent: :destroy
  has_many :links, dependent: :destroy
  has_many :withdrawals
  has_many :notifications, dependent: :destroy
  has_many :learn_and_earns, dependent: :destroy
  has_many :contact_message, dependent: :destroy

  def total_earned
    clicks.count* 0.0003222222222
  
  end
end

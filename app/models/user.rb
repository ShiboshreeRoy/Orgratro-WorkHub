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

  has_many :user_links
  has_many :seen_links, through: :user_links, source: :link


  def total_earned
    clicks.count* 0.0003222222222
  end

   # Prevent login if suspended
  def active_for_authentication?
    super && !suspended?
  end

  # Optional: custom message
  def inactive_message
    !suspended? ? super : :suspended
  end

  def self.ransackable_attributes(auth_object = nil)
    ["balance", "created_at", "email", "encrypted_password", "id", "id_value", "remember_created_at", "reset_password_sent_at", "reset_password_token", "role", "suspended", "updated_at"]
  end

end

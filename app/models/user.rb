class User < ApplicationRecord
  has_one_attached :avatar
  has_secure_password validations: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_many :microposts, dependent: :destroy

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA256.hexdigest(token.to_s)
  end
  
end

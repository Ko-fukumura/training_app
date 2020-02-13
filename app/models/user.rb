class User < ApplicationRecord
  attr_accessor :activation_token
  before_create :create_activation_digest
  has_one_attached :avatar
  has_secure_password validations: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_many :microposts, dependent: :destroy

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA256.hexdigest(token.to_s)
  end

  private

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.encrypt(activation_token.to_s)
    end
  
end

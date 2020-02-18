class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_create :create_activation_digest
  has_one_attached :avatar
  has_secure_password validations: true
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/
  validates :email, presence: true, length: { maximum: 50 }, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_many :microposts, dependent: :destroy

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    Digest::SHA256.hexdigest(token.to_s)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    User.digest(token) == digest
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_attribute(:activated, true)
  end

  def send_activation_email
    SendgridMailer.account_activation(self).deliver_now
  end

  private

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
  
end

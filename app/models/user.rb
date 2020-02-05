class User < ApplicationRecord
  has_one_attached :avatar
  has_secure_password validations: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_many :microposts, dependent: :destroy
end

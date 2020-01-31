class User < ApplicationRecord
  has_secure_password validations: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_many :microposts, dependent: :destroy
end

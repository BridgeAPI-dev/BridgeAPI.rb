class User < ApplicationRecord
  has_secure_password :password
  has_secure_password :recovery_password, validations: false
  validates :email, presence: true, uniqueness: true
end

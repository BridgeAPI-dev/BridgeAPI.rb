class User < ApplicationRecord
  attr_accessor :password_digest, :recovery_password_digest
  has_secure_password :password 
  has_secure_password :recovery_password, validations: false  
  validates :email, presence: true, uniqueness: true 
  validates :password, :password_digest, presence: true
end


class Bridge < ApplicationRecord
  has_many :env_vars
  has_many :headers
  has_many :events
end

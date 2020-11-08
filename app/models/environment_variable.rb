class EnvironmentVariable < ApplicationRecord
  validates :key, length: { minimum: 1 }
  validates :value, length: { minimum: 1 }
  
  belongs_to :bridge
end

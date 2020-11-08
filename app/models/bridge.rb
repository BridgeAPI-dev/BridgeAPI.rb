class Bridge < ApplicationRecord
  validates :name, length: { minimum: 1 }
  validates :inbound_url, length: { minimum: 1 }
  validates :outbound_url, length: { minimum: 1 }
  validates :method, length: { minimum: 3 }
  validates :delay, :numericality => { greater_than_or_equal_to: 0 }
  validates :retries, :numericality => { greater_than_or_equal_to: 0 }


  has_many :env_vars, class_name: "EnvironmentVariable"
  has_many :headers
  has_many :events
end

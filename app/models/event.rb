class Event < ApplicationRecord
  validates :outbound_url, length: { minimum: 1 }

  belongs_to :bridge
end

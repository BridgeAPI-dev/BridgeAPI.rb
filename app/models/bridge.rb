# frozen_string_literal: true

require 'securerandom'

METHODS ||= %w[
  DELETE
  GET
  PATCH
  POST
  PUT
].freeze

DELAYS ||= [
  0,
  15,
  30,
  60,
  1440
].freeze

RETRIES ||= [
  0,
  1,
  3,
  5
].freeze

class Bridge < ApplicationRecord
  before_validation :set_inbound_url, on: :create
  validates :name, presence: true
  validates :inbound_url, presence: true, uniqueness: true
  validates :outbound_url, presence: true
  validates :data, presence: true
  validates :method, inclusion: METHODS
  validates :delay, inclusion: DELAYS
  validates :retries, inclusion: RETRIES

  belongs_to :user
  has_many :environment_variables, dependent: :destroy
  has_many :headers, dependent: :destroy
  has_many :events, dependent: :destroy
  belongs_to :user

  private

  def set_inbound_url
    self.inbound_url = SecureRandom.hex(10)
  end
end

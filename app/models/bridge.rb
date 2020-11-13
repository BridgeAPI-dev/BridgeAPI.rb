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
  before_validation :set_payloads, on: :create
  validates :name, presence: true
  validates :inbound_url, presence: true, uniqueness: true
  validates :outbound_url, presence: true
  validates :method, inclusion: METHODS
  validates :delay, inclusion: DELAYS
  validates :retries, inclusion: RETRIES
  validate :payloads_are_valid

  belongs_to :user
  has_many :environment_variables, dependent: :destroy
  has_many :headers, dependent: :destroy
  has_many :events, dependent: :destroy
  accepts_nested_attributes_for :headers, :environment_variables

  def set_payloads
    self.data = { payload: {}, test_payload: {} } if data.nil?
  end

  def populate_data(user, payload, test_payload)
    self.user = user
    self.data = { payload: payload, test_payload: test_payload } if payload && test_payload
  end

  private

  def payloads_are_valid
    return if data['payload'].instance_of?(Hash) && data['test_payload'].instance_of?(Hash) && self.data.keys.count == 2

    errors.add(:data, 'must only contain a payload and a test payload and each must be a hash')
  end

  def set_inbound_url
    self.inbound_url = SecureRandom.hex(10)
  end
end

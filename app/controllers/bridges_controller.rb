class BridgesController < ApplicationController 
  has_many :env_vars
  has_many :headers
  has_many :events
end
# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authorize_request
  # Needs to find all events based on bridge_id or event_id
  # Needs to return id for each event as well
  def index
    events = @current_user.bridges
    events.map do |event|
      updated_at = String(event.updated_at)
      date = date_format(updated_at.split(' ')[1])
      time = updated_at.split(' ')[0]

      { time: time,
        date: date,
        status_code: event.status_code }
    end
  end

  # def show; end

  private

  def date_format(_date)
    year = time.split('-')[0]
    month = time.split('-')[1]
    day = time.split('-')[2]
    "#{year}-#{month}-#{day}"
  end
end

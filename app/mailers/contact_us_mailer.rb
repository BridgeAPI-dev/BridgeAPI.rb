# frozen_string_literal: true

class ContactUsMailer < ApplicationMailer
  before_action { @sender = params['email'] }
  default from: @sender

  def contact_us
    @full_name = params['full_name']
    @message = payload['message']
    @subject = payload['subject']
    
    mail subject: "BRIDGEAPI - #{@subject}"
  end
end

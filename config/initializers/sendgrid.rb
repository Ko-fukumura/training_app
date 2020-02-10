sendgrid_api_key = Rails.application.credentials.dig(:sendgrid_api_key)
ActionMailer::Base.add_delivery_method :sendgrid, Mail::SendGrid, api_key: :sendgrid_api_key

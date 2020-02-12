class Mail::SendGrid
  def initialize(settings)
    @settings = settings
  end

  def deliver!(mail)
    sg_mail = SendGrid::Mail.new
    sg_mail.from = SendGrid::Email.new(email: mail.from.first)
    sg_mail.subject = mail.subject
    personalization = SendGrid::Personalization.new
    personalization.add_to(SendGrid::Email.new(email: mail.to.first))
    personalization.subject = mail.subject
    sg_mail.add_content(SendGrid::Content.new(type: 'text/plain', value: mail.body.raw_source))
    sg_mail.add_personalization(personalization)

    sg = SendGrid::API.new(api_key: Rails.application.credentials.dig(:sendgrid_api_key))
    response = sg.client.mail._('send').post(request_body: sg_mail.to_json)
    Rails.logger.info response.status_code
  end
end
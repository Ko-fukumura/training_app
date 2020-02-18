class  SendgridMailerPreview < ActionMailer::Preview

  # Preview this email at
  # http://localhost:3000/rails/mailers/sendgrid_mailer/account_activation
  def account_activation
    user = User.first
    user.activation_token = User.new_token
    SendgridMailer.account_activation(user)
  end

end
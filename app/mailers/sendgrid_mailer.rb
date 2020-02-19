class SendgridMailer < ApplicationMailer

  def test_mail(user)
    @user = user
    mail(from: 'from@example.com', to: @user.email, subject: 'テストメール')
  end

  def account_activation(user)
    @user = user
    mail(from: 'from@example.com', to: @user.email, subject: 'Account activation')
  end
end
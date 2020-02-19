class SendgridMailer < ApplicationMailer

  def test_mail
    mail(from: 'from@example.com', to: 'shamballa-o-k.f@ezweb.ne.jp', subject: 'テストメール')
  end

  def account_activation(user)
    @user = user
    mail(from: 'from@example.com', to: @user.email, subject: "Account activation")
  end
end
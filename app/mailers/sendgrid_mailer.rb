class SendgridMailer < ApplicationMailer
  def test_mail
    mail(from: 'from@example.com', to: 'shamballa-o-k.f@ezweb.ne.jp', subject: 'テストメール')
  end
end
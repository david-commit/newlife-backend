class MyMailer < ApplicationMailer
  def send_email(to, subject, body)
    @body = body
    mail(to: to, subject: subject, body: body)
  end
end

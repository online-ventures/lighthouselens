class ApplicationMailer < ActionMailer::Base
  default from: 'steviegronow@comcast.net'
  layout 'mailer'

  def contact_email
    @name = params[:name]
    @email = params[:email]
    @body = params[:body]
    @subject = 'Message sent using your contact form on Lighthouse Lens';
    mail(to: @email, subject: @subject);
  end
end

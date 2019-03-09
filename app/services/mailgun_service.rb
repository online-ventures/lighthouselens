class MailgunService
  @@from = 'Lighthouselens.com <support@lighthouselens.com>'

  class << self
    def send_contact_email(params)
      raise 'Recipient not set' unless recipient
      params[:body] = convert_text_to_html(params[:body])
      html = render_html(template: 'contact', data: params)
      message = build_message(params, html)
      result = client.send_message(domain, message).to_h!
      Rails.logger.info "Sent an email to Mailgun.  Received message: #{result['message']}"
    end

    def build_message(data, html)
      msg = Mailgun::MessageBuilder.new
      msg.from 'support@lighthouselens.com', 'full_name' => 'lighthouselens.com'
      msg.subject 'Lighthouse Lens message'
      msg.reply_to data[:email]
      msg.add_recipient(:to, ENV['CONTACT_RECIPIENT'])
      msg.body_html html
      msg
    end

    def recipient
      ENV['CONTACT_RECIPIENT']
    end

    def client
      @@client ||= Mailgun::Client.new Rails.application.credentials.mailgun_api_key
    end

    def domain
      'mg.lighthouselens.com'
    end

    def convert_text_to_html(text)
      text.gsub("\n", '<br>').html_safe
    end

    def render_html(template:, data: {})
      ApplicationController.render(
        "emails/#{template}",
        assigns: data,
        layout: false
      )
    end
  end
end

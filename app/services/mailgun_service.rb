class MailgunService
  class << self
    def send_contact_email(inquiry_id)
      raise 'Recipient not set' unless recipient
      inquiry = Inquiry.find inquiry_id
      data = inquiry.slice(:name, :email, :comments, :item_id)
      data[:comments] = convert_text_to_html(data[:comments])
      data[:item] = Item.find(data[:item_id]) if data[:item_id].present?
      html = render_html(template: 'contact', data: data)
      message = build_message(data, html)
      send_message message, inquiry
    end

    def send_message(message, inquiry)
      response = client.send_message(domain, message)
      InquiryResponse.create(
        inquiry: inquiry,
        code: response.code,
        message: response.to_h['message']
      )
      Rails.logger.info "Sent an email to Mailgun.  Received code: #{response.code}"
      raise 'Mailgun failed to queue message' unless response.code.between?(200, 299)
    end

    def build_message(data, html)
      msg = Mailgun::MessageBuilder.new
      msg.from 'support@lighthouselens.com', 'full_name' => 'lighthouselens.com'
      msg.subject 'Lighthouse Lens message'
      msg.reply_to data[:email]
      msg.add_recipient(:to, recipient)
      msg.body_html html
      msg
    end

    def recipient
      ENV['CONTACT_RECIPIENT']
    end

    def client
      @@client ||= Mailgun::Client.new Rails.application.credentials.mailgun[:api_key]
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

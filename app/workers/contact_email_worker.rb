class ContactEmailWorker
  include Sidekiq::Worker

  def perform(inquiry_id)
    MailgunService.send_contact_email inquiry_id
  end
end

class ContactEmailWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  def perform(inquiry_id)
    MailgunService.send_contact_email inquiry_id
  end
end

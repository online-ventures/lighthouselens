class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new message_params
    if @message.valid?
      MailgunService.send_contact_email(message_params)
      redirect_to new_message_url
      flash[:success] = "We have received your message and will be in touch soon!"
    else
      @errors = @message.errors.full_messages
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :body)
  end
end
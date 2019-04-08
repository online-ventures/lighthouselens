class MessagesController < ApplicationController
  def new
    @inquiry = Inquiry.new item_id: params[:id]
  end

  def create
    @inquiry = Inquiry.new message_params
    if @inquiry.save
      ContactEmailWorker.perform_async @inquiry.id
      redirect_to new_message_path
      flash[:success] = "We have received your message and will be in touch soon!"
    else
      @errors = @inquiry.errors.full_messages
      render :new
    end
  end

  private

  def message_params
    params.require(:inquiry).permit(:name, :email, :comments, :item_id)
  end
end

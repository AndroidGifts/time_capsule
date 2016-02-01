class MessagesController < ApplicationController
  
  def index
    @messages = Message.msg_public
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      #message saved succesfully
    else
      #message not saved
    end
  end

  def edit
  end

  def delete
  end

  private
  def message_params
    params.require(:message).permit(:msg_public, :msg_to, :subject, :content, :delivery_date, :delivery_time)
  end
end

class MessagesController < ApplicationController
  
  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.msg_public = params[:msg_public]

    if @message.save
      redirect_to message_path(@message)
    else
      render 'new'
    end
  end

  def edit
    @message = Message.find(params[:id])
  end

  def update
    @message = Message.find(params[:id])
    @message.update(:msg_public => params[:msg_public])
    if @message.update(message_params)
      redirect_to message_path(@message)
    else
      render 'edit'
    end
  end

  def delete
    @message = Message.find(params[:id])
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to root_path
  end

  def like_message
    message = Message.find(params[:id])
    self.increment!(:like_count)

    render :nothing => true
  end

  def message_params
    params.require(:message).permit(:msg_public, :msg_to, :subject, :content, :delivery_date, :delivery_time)
  end
end

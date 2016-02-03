class MessagesController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :delete, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @messages = Message.all
  end

  def show
  end

  def new
    @message = current_user.messages.build
  end

  def create
    @message = current_user.messages.build(message_params)
    @message.msg_public = params[:msg_public]

    if @message.save
      redirect_to message_path(@message)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @message.update(:msg_public => params[:msg_public])
    if @message.update(message_params)
      redirect_to message_path(@message)
    else
      render 'edit'
    end
  end

  def delete
  end

  def destroy
    @message.destroy
    redirect_to root_path
  end

  def like_message
    message = Message.find(params[:id])
    self.increment!(:like_count)

    render :nothing => true
  end

  private
  def find_post
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:msg_public, :msg_to, :subject, :content, :delivery_date, :delivery_time)
  end
end

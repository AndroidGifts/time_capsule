class MessagesController < ApplicationController
  before_action :find_message, only: [:edit, :update, :delete, :destroy]
  
  def index
    @messages = Message.all
  end

  # Sent Params: id (Integer)
  # Returned Params: Message (id, subject, content, created_at, delivery_date, like_count), User Object (id, full_name, user_avatar), 
  # Comments Object (id, content, user_name, user_avatar)
  # If Failed, the returned params will be code(0), msg
  # Example: http://localhost:3000/messages/show/{message_id}
  def show
    begin
      @message = Message.find params[:id]
      render json: @message, each_serializer: MessageSerializer
    rescue ActiveRecord::RecordNotFound => e
      render json: { "code" => 0, "msg" => "No message found" }
    end
  end

  def new
    @message = Message.new
  end

  # user_id, subject, content, msg_to, delivery_date, delivery_time, msg_public
  def create
    @message = Message.new(message_params)
    @message.msg_public = params[:msg_public]
    @message.user_id = params[:user_id]

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

  # Returned Params for each message: id, subject, content, created_at, user_name
  # If Failed, the returned params will be code(0), msg
  # Example: http://localhost:3000/messages/get_public_messages
  def get_public_messages
    @messages = Message.msg_public
    if @messages.empty?
      render json: { "code" => 0, "msg" => "No Messages Found" }
    else
      render json: @messages, each_serializer: PublicMessagesSerializer
    end
  end

  # Sent Params: user_id (Integer), subject (String), content (Text), msg_to (Text), delivery_date (String), delivery_time (String), msg_public (Boolean)
  # Returned Params: code (0 if fails, 1 if succeeded), msg
  # http://localhost:3000/messages/create_new_message?user_id=&subject=&content=&msg_to=&delivery_date=&delivery_time=&msg_public=
  def create_new_message
    @message = Message.new(message_service_params)

    if @message.save
      response = { "code" => 1, "msg" => "Message Created Successfully" }
    else
      response = { "code" => 0, "msg" => "Message Can't be created" }
    end

    render json: response
  end

  private
  def find_message
    @message = Message.find(params[:id])
  end

  def message_service_params
    params.permit(:user_id, :msg_public, :msg_to, :subject, :content, :delivery_date, :delivery_time)
  end

  def message_params
    params.require(:message).permit(:user_id, :msg_public, :msg_to, :subject, :content, :delivery_date, :delivery_time)
  end
end

class CommentsController < ApplicationController

  def index
  end

  def show
  end

  def new
  end

  def create
    @message = Message.find(params[:message_id])
    @comment = @message.comments.create(params[:comment].permit(:content))
    #@comment.user = current_user

    if @comment.save
      redirect_to message_path(@message)
    else
      render('new')
    end
  end

  def edit
    @message = Message.find(params[:message_id])
    @comment = @message.comments.find(params[:id])
  end

  def update
    @message = Message.find(params[:message_id])
    @comment = @message.comments.find(params[:id])

    if @comment.update(params[:comment].permit(:content))
      redirect_to message_path(@message)
    else
      render 'edit'
    end
  end

  def delete
  end

  # Params: message_id (Integer), user_id (Integer), content (Text)
  # Example: localhost:3000/comments/create_comment?message_id=&content=&user_id=
  def create_comment
    @user = User.find(params[:user_id])
    @message = Message.find(params[:message_id])
    @comment = @message.comments.create(params.permit(:content))
    @comment.user = @user
    @comment.user_name = @user.id
    @comment.user_avatar = @user.id

    if @comment.save
      response = { "code" => 1, "msg" => "Comment Created Successfully" }
    else
      response = { "code" => 0, "msg" => "Comment Can't be created" }
    end

    render json: response
  end

  def destroy
    @message = Message.find(params[:message_id])
    @comment = @message.comments.find(params[:id])

    @comment.destroy
    redirect_to message_path(@message)
  end
end

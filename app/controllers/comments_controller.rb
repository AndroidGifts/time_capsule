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
    @comment.user = current_user

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

  def destroy
    @message = Message.find(params[:message_id])
    @comment = @message.comments.find(params[:id])

    @comment.destroy
    redirect_to message_path(@message)
  end
end

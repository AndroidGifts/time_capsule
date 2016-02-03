class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to(:action => 'show', :id => @user.id)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to(:action => 'show', :id => @user.id)
    else
      render 'edit'
    end
  end

  def delete
    @user = User.find(params[:id])
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to(:action => 'index')
  end

  # App send email, first_name, last_name, user_avatar
  # Check the email sent from the app
  # If user already exist, respond with the user ID
  # If user doesn't exist, create new user and respond with the user ID
  # If user couldn't be saved, respond with 0
  def user_login
    @user = User.find_by_email(params[:email])

    if @user.present?
      # response -- User Found and this is his ID
      render :text => "User exist"
    else
      # User Not found, will create one and this is his ID
      render :text => "User doesn't exist"

      new_user = User.new(:email => params[:email], :first_name => params[:first_name], 
        :last_name => params[:last_name], :user_avatar => params[:user_avatar])

      if new_user.save
        # response -- with new user ID
        puts "New user saved and his ID "
      else
        # response -- with 0, Failed to create new user
        puts "User can't be created"
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :user_avatar)
  end
end
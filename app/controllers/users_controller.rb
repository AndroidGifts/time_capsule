class UsersController < ApplicationController

  def index
    @users = User.all
    #render json: @users
  end

  def get_all_users
    @users = User.first
    @users.full_name = @users.first_name + ' ' + @users.last_name
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    #render json: @user
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
  # Params : email, first_name, last_name, user_avatar
  # Example : http://localhost:3000/users/user_login?email=foo@gmail.com&first_name=foo&last_name=doo&user_avatar=myavatar
  # Response : code, user_id, msg
  def user_login
    @user = User.find_by_email(params[:email])

    if @user.present?
      # response -- User Found and this is his ID
      response = { "code" => 1, "user_id" => @user.id, "msg" => "User Found" }
    else
      new_user = User.new(:email => params[:email], :first_name => params[:first_name], 
        :last_name => params[:last_name], :user_avatar => params[:user_avatar])

      if new_user.save
        # User Not found, will create one and this is his ID
        response = { "code" => 1, "user_id" => new_user.id, "msg" => "New User Created" }
      else
        # response -- with 0, Failed to create new user
        response = { "code" => 0, "msg" => "User Can't be created" }
      end
    end

    # Send the response in JSON
    render json: response
  end

  # Params : user_id
  # Returned Params: id, full_name, user_avatar
  # Example : http://localhost:3000/users/get_user_details?user_id=22
  def get_user_details
    @user = User.find_by_id(params[:user_id])
    render json: @user
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :user_avatar)
  end
end
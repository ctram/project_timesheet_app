# require 'pry'
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if @user.id != session[:user_id]
      flash[:notice] = "You must be logged in as that user to access that page."
      redirect_to users_path
    end
  end

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    if params[:password] != params[:password_confirmation]
      flash[:error] = "Your password do not match."
      render :new
    else
      @user = User.new(user_params)
      if @user.save
        flash[:notice] = "You've successfully registered!"
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        render :new
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name,:last_name,:department_id, :username, :password, :password_confirmation)
  end
end

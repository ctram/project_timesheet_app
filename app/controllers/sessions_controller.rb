class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # TODO: find matching username.
    # If user exists, check password
    # else return to :new
    user = !User.find_by(username: params[:username])
    if !user or !user.authenticate(params[:password])
      flash[:notice] = "Something is wrong with your username or password."
      render :new
    else
      flash[:notice] = "You are now logged in."
      redirect_to user_path(user)
    end
  end
end

class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(username: params[:username])

    if !user or !user.authenticate(params[:password])
    binding.pry
      flash[:error] = "Something is wrong with your username or password."
      render :new
    else
      session[:user_id] = user.id
      flash[:notice] = "You are now logged in."
      redirect_to user_path(user.id)
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've successfull logged out."
    redirect_to root_path
  end


end

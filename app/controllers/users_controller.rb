# require 'pry'
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    binding.pry

    if @user.save
      flash[:notice] = "You've successfully created a new account."
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name,:last_name,:department_id)
  end
end

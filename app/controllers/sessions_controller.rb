class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # TODO: find matching username.
    # If user exists, check password
    # else return to :new
    user = User.new(params.require(:user).permit!)

    password = user.password

  end


end

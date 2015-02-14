class DaysController < ApplicationController
  def new
    # binding.pry
    @user = User.find(params[:user_id])
    @day = Day.new
  end


  private


end

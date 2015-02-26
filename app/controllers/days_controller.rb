class DaysController < ApplicationController
  before_action :load_user_and_month

  def edit
    flash.keep
    
  end

  def show
  end

  private

  def day_params
    params.require(:day).permit(:name)
  end

  def load_user_and_month
    @user = User.find(params[:user_id])
    @month = Month.find(params[:month_id])
    @day = Day.find(params[:id])
  end


end

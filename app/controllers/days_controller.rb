class DaysController < ApplicationController
  before_action :load_user_and_month

  def new
    # binding.pry
    @user = User.find(params[:user_id])
    @month = Month.find(params[:month_id])
    @day = Day.new
  end

  def create
    @day = Day.new(day_params)
    @day.month_id = @month.id

      binding.pry
    if @day.save
      flash[:notice] = "New day created."
      redirect_to user_month_path(@user, @month)
    else
      render :new
    end
  end


  private

  def day_params
    params.require(:day).permit(:name)
  end

  def load_user_and_month
    @user = User.find(params[:user_id])
    @month = Month.find(params[:month_id])
  end


end

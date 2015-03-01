class DaysController < ApplicationController
  before_action :load_user_and_month

  def edit
    # TODO: code days#edit view template to show an editable table of allocations
    # If day does not have alloactions, redirect to the day#new action
    # load a @allocations_array
    @allocations = @day.allocations

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

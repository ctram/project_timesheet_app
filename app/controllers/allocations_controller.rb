class AllocationsController < ApplicationController
  def edit
    @user = current_user
    @month = Month.find(params[:month_id])
    @day = Day.find(params[:day_id])
    @allocation = Allocation.find(params[:id])
    if !@user.months.find(@month.id).days.find(@day.id).allocations.include? @allocation
      flash[:notice] = "You must be logged in as that user to view that data."
      redirect_to user_path
    end
  end

end

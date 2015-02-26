class AllocationsController < ApplicationController
  before_action :load_user_and_month

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

  def new
    @allocation = Allocation.new
  end

  def create
    @allocation = Allocation.new params_allocation
    if @allocation.save
      @day.allocations << @allocation
      @day.save
      flash[:notice] = "Allocation saved."
      redirect_to edit_user_month_day_path(@user, @month, @day)
    else
      flash[:error] = "An error occured -- the allocation was not saved."
      render :new
    end
  end

  private

  def load_user_and_month
    @user = User.find(params[:user_id])
    @month = Month.find(params[:month_id])
    @day = Day.find(params[:day_id])
  end

  def params_allocation
    params.require(:allocation).permit!
  end

end

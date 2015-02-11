class MonthsController < ApplicationController
  def show
    @user = current_user
    @month = Month.find(params[:id])
    if !@user.months.include? @month
      flash[:notice] = "You must be logged in as that user to view that data."
      redirect_to user_path
    end
  end


  def edit
    @user = current_user
    @month = Month.find(params[:id])
    if !@user.months.include? @month
      flash[:notice] = "You must be logged in as that user to view that data."
      redirect_to user_path
    end
  end
end

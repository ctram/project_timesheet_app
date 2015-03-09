
class MonthsController < ApplicationController
  def show
    @user = current_user
    @month = Month.find(params[:id])
    if !@user.months.include? @month
      flash[:notice] = "You must be logged in as that user to view that data."
      redirect_to user_path
    end
    #
  end


  def edit
    @user = current_user
    @month = Month.find(params[:id])
    if !@user.months.include? @month
      flash[:notice] = "You must be logged in as that user to view that data."
      redirect_to user_path
    end
  end

  def new
    @user = User.find(params[:user_id])
    @month = Month.new
  end

  def create
    @user = User.find(params[:user_id])
    year = params[:month]["name(1i)"].to_i
    month_number = params[:month]['name(2i)'] #String
    month_name = case month_number
      when '1'
        'January'
      when '2'
        'February'
      when '3'
        'March'
      when '4'
        'April'
      when '5'
        'May'
      when '6'
        'June'
      when '7'
        'July'
      when '8'
        'August'
      when '9'
        'September'
      when '10'
        'October'
      when '11'
        'November'
      when '12'
        'December'
    end

    @month = Month.new(name:month_name, year:year, user_id: @user.id)

    if @month.save
      flash[:notice] = "You have added a month."
    @month.populate_days month_number.to_i
      redirect_to user_path(@user)
    else
      flash[:error] = "Something wrong occured."
      render :new
    end
  end

  def destroy
    @user = User.find params[:user_id]
    @month = Month.find params[:id]
    Month.delete @month.id
    flash[:notice] = "#{@month.year} #{@month.name} has been deleted"
    redirect_to user_path @user
  end

end

class DaysController < ApplicationController
  before_action :load_user_and_month

  def show


  end

  def edit

    # If day does not have alloactions, redirect to the day#new action
    # load a @allocations_array
    @allocations = @day.allocations
  end

  def update
    @allocations = []
    params_proj_codes = params.select do |k,v|
      k.include? 'project_code'
    end
    num_proj_codes = params_proj_codes.count / 2
    (0..num_proj_codes-1).each do |i|
      @allocations << Allocation.new(project_code:params_proj_codes["project_code_#{i}_name"].upcase, percentage:params_proj_codes["project_code_#{i}_perc"], day_id: @day.id) unless params_proj_codes["project_code_#{i}_perc"] == ""
    end

    # Test that allocations sum to 100%
    sum_allocations = @allocations.reduce(0) do |m,a|
      m + a.percentage
    end

    if sum_allocations == 0 or sum_allocations != 100
      flash[:error] = "Percentages allocated must equal 100%"
      render :edit
    else
      # Save allocations
      @allocations.each do |a|
        a.save
      end
      @day.allocations = @allocations
      redirect_to user_month_day_path(@user, @month, @day)
    end
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

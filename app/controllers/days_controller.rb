class DaysController < ApplicationController
  before_action :load_user_and_month

  def show

  end

  def edit
    binding.pry
    # TODO: code days#edit view template to show an editable table of allocations
    # If day does not have alloactions, redirect to the day#new action
    # load a @allocations_array
    @allocations = @day.allocations
  end

  # FIXME: when using days#edit, params seems to be carrying over and adding more allocations than needed to the day object.
  def update
    binding.pry
    @allocations = []
    params_proj_codes = params.select do |k,v|
      k.include? 'project_code'
    end
    num_proj_codes = params_proj_codes.count / 2
    (0..num_proj_codes-1).each do |i|
      @allocations << Allocation.create(project_code:params_proj_codes["project_code_#{i}_name"], percentage:params_proj_codes["project_code_#{i}_perc"], day_id: @day.id) unless params_proj_codes["project_code_#{i}_perc"] == ""
    end
    # TODO: allocations must total to 100% each day
    if @day.sum_percentages != 0 and @day.sum_percentages != 100
      flash[:error] = "Percentages allocated must equal 100%"
      render :edit
    else
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

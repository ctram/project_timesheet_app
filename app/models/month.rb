class Month < ActiveRecord::Base
  belongs_to :user
  has_many :days

  validates :name, presence: true
  validates :user_id, presence: true
  validates :year, presence: true

  def populate_days month_number
    # Determine how many Day objects to create.
    if [1,3,5,7,8,10,12].include? month_number
      num_days = 31
    elsif [4,6,9,11].include? month_number
      num_days = 30
    else
      # TODO: code a way to account for leap years where Feb will have 29 days
      num_days = 28
    end

    (1..num_days).each do |date_num|
      Day.create(month_id: self.id, number:date_num)
    end
  end

  # Return number of days with non-zero allocations
  def num_days_w_allocations
    self.days.select{|d| d.allocations != []}.count
  end

  # Return the averaged percentage worked on project code for the month.
  def project_code_percentage_average project_code
    if unique_project_codes.include? project_code
      sum = 0
      self.days.each do |d|
        if d.allocations != []
          d.allocations.each do |a|
            sum += a.percentage if a.project_code == project_code
          end
        end
      end
      sum.to_f / num_days_w_allocations
    else
      0
    end
  end

  def sum_project_code_percentage_averages
    sum = 0
    unique_project_codes.each do |project_code|
      sum += project_code_percentage_average(project_code)
    end
    sum
  end

  # Return a sorted array of strings; the Month's unique project codes
  def unique_project_codes
    project_codes = []
    days = self.days
    days.each do |d|
      d.allocations.each do |a|
        project_codes << a.project_code.upcase
      end
    end  # project_codes is array of all project_code strings within the month.
    uniq_project_codes = project_codes.uniq
    uniq_project_codes.sort
  end

  def most_number_of_allocations
    days = self.days
    max_num_allocations = 0
    days.each do |day|
      if day.allocations.count > max_num_allocations
        max_num_allocations = day.allocations.count
      end
    end
    max_num_allocations
  end

  def num_uniq_project_codes
    project_codes.count
  end

  def project_codes
    # returns array of uniqe project codes
    project_codes = []
    self.days.each do |day|
      day.allocations.each do |a|
        project_codes << a.project_code
      end
    end
    project_codes.uniq
  end
end

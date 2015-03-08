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
  # TODO: Month view totals averaged percentages for each project code - code this in the month.rb
end

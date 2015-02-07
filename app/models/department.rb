class Department < ActiveRecord::Base
  has_many :users

  def department_name
    "#{name}"
  end
end

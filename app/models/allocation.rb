class Allocation < ActiveRecord::Base
  belongs_to :day

  validates :project_code, presence: true
  validates :percentage, presence:true
  

end

class Day < ActiveRecord::Base
  belongs_to :month
  has_many :allocations

  validates :name, presence: true, uniqueness: true
  validates :month_id, presence: true


end

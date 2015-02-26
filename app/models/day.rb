class Day < ActiveRecord::Base
  belongs_to :month
  has_many :allocations

  validates :month_id, presence: true

  def num_allocations
    self.allocations.count
  end
end

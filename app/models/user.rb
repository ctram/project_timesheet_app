class User < ActiveRecord::Base
  belongs_to :department
  validates :first_name, :last_name, presence: true

end

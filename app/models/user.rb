class User < ActiveRecord::Base
  belongs_to :department
  has_many :months

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  validates :department_id, presence: true
  has_secure_password
end

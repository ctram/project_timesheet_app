class User < ActiveRecord::Base
  belongs_to :department
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true
  validates :password, presence: true
  validates :department_id, presence: true
  has_secure_password
end

class Job < ActiveRecord::Base
  has_many :job_users
  has_many :users, :through => :job_users
  has_many :announces
end
class User < ActiveRecord::Base
  has_many :text_jobs
  has_many :jobs, through: :text_jobs
end

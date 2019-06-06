class Job < ActiveRecord::Base
	belongs_to :job_type
	has_many :text_jobs
	has_many :users, through: :text_jobs
end

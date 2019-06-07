class Job < ActiveRecord::Base
	belongs_to :job_type
	has_many :text_jobs
	has_many :users, through: :text_jobs

	# Returns users job was sent to through text_jobs
	def sent_to
		self.users
	end

	# Returns users who clicked on application link
	def seen_by
		TextJob.where(job_id: self.id, clicked: true).includes(:user).map{ |text_job| text_job.user }
	end
end

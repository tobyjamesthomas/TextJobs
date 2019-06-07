class User < ActiveRecord::Base
  has_many :text_jobs, dependent: :destroy
  has_many :jobs, through: :text_jobs

  # Returns jobs received through text_jobs
  def jobs_received
    self.jobs
  end
end

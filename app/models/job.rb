class Job < ActiveRecord::Base
	belongs_to :job_type
	has_many :text_jobs, dependent: :destroy
	has_many :users, through: :text_jobs

	# Returns users job was sent to through text_jobs
	def sent_to
		self.users
	end

	# Returns users who clicked on application link
	def seen_by
		TextJob.where(job_id: self.id, clicked: true).includes(:user).map{ |text_job| text_job.user }
	end

	def send_texts
		# Twilio credentials
		account_sid = ENV["TWILIO_ACCOUNT_SID"]
		auth_token = ENV["TWILIO_AUTH_TOKEN"]

		# Set up a client to talk to the Twilio REST API
		@client = Twilio::REST::Client.new account_sid, auth_token

		# Twilio phone number
		from_number = ENV["TWILIO_FROM_NUMBER"]

		# Get job type
		job_type = self.job_type.name.downcase.tr(" ","_")

		User.where(job_type => true).each do |user|
			# Create text job
			text_job = TextJob.new(job: self, user: user, to: user.phone, from: from_number)

			if text_job.save

				# Generate custom url with TinyURL
				long_url = ENV['DOMAIN'] + "/text_jobs/" + text_job.id.to_s
				short_url = ShortURL.shorten(long_url, :tinyurl)

				# Create body message
				body = user.first_name + ", " + self.employer + " is hiring a " + self.title + " in " + self.location + ". It pays $" + ('%.2f' % self.wage) + "/hr. Apply at " + short_url + " before " + self.expiry.strftime("%b %-d") + "."

				# Send text message via Twilio
				message = @client.account.messages.create(:body => body,
				:to => user.phone,
				:from => from_number)

				puts message.sid

				# Update text_job url and body
				text_job.update(url: short_url, body: body)
			end
		end
	end
end

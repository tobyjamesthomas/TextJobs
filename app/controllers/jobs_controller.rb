class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  #require 'twilio-ruby'

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save

        # put your own credentials here
        account_sid = ENV["TWILIO_ACCOUNT_SID"]
        auth_token = ENV["TWILIO_AUTH_TOKEN"]

        # set up a client to talk to the Twilio REST API
        @client = Twilio::REST::Client.new account_sid, auth_token

        # Twilio number
        from_number = ENV["TWILIO_FROM_NUMBER"]

        # get job type
        job_type = @job.job_type.name.downcase.tr(" ","_")


        User.where(job_type => true).each do |user|

          # create body message
          body = user.first_name + ", " + @job.employer + " is hiring a " + @job.title + " in " + @job.location + ". It pays $" + ('%.2f' % @job.wage) + "/hr. Apply at " + @job.link + " before " + @job.expiry.strftime("%b %-d") + "."

          message = @client.account.messages.create(:body => body,
          :to => user.phone,
          :from => from_number)

          puts message.sid

        end

        format.html { redirect_to new_job_path, notice: 'Your job posting was sent to interested candidates. Now sit back and wait for the applications to roll in.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:employer, :title, :job_type_id, :description, :location, :wage, :expiry, :link)
    end
end

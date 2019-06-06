class TextJobsController < ApplicationController
  before_action :set_text_job, only: [:show, :edit, :update, :destroy]

  # GET /text_jobs
  # GET /text_jobs.json
  def index
    @text_jobs = TextJob.all
  end

  # GET /text_jobs/1
  # GET /text_jobs/1.json
  def show
    @text_job = TextJob.find(params[:id])

    if !@text_job.clicked
      @text_job.update(clicked: true)
    end

    redirect_to @text_job.job.link
  end

  # GET /text_jobs/new
  def new
    @text_job = TextJob.new
  end

  # GET /text_jobs/1/edit
  def edit
  end

  # POST /text_jobs
  # POST /text_jobs.json
  def create
    @text_job = TextJob.new(text_job_params)

    respond_to do |format|
      if @text_job.save
        format.html { redirect_to @text_job, notice: 'Text Job was successfully created.' }
        format.json { render :show, status: :created, location: @text_job }
      else
        format.html { render :new }
        format.json { render json: @text_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /text_jobs/1
  # PATCH/PUT /text_jobs/1.json
  def update
    respond_to do |format|
      if @text_job.update(text_job_params)
        format.html { redirect_to @text_job, notice: 'Job type was successfully updated.' }
        format.json { render :show, status: :ok, location: @text_job }
      else
        format.html { render :edit }
        format.json { render json: @text_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /text_jobs/1
  # DELETE /text_jobs/1.json
  def destroy
    @text_job.destroy
    respond_to do |format|
      format.html { redirect_to text_jobs_url, notice: 'Job type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_text_job
      @text_job = TextJob.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def text_job_params
      params.require(:text_job).permit(:name)
    end
end

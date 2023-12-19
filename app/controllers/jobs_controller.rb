# frozen_string_literal: true

class JobsController < BaseController
  before_action :authorize_request
  before_action :find_job, only: %i[show edit update destroy toggle_published]

  def index
    @jobs = Job.ordered.page(params[:page])
  end

  def new
    @job = Job.new
  end

  def edit; end

  def update
    if @job.update(job_params)
      redirect_to jobs_path, notice: 'Job updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to jobs_path, notice: 'Job Created Successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    flash[:notice] = 'Job is deleted' if @job.destroy

    redirect_to jobs_path
  end

  def toggle_published
    @job.update(published: !@job.published)

    respond_to do |format|
      format.json { render json: { job: @job } }
    end
  end

  def for_student
    @jobs = Job.where(published: true).ordered
    @applied_jobs = current_user.job_applications.map(&:job)
    @available_jobs = @jobs - @applied_jobs
  end

  private

  def authorize_request
    authorize %i[job]
  end

  def find_job
    @job = Job.find_by(slug: params[:id])

    return redirect_back(fallback_location: jobs_path) if @job.blank?
  end

  def job_params
    params.require(:job).permit(:id, :title, :description, :location, :job_type, :published)
  end
end


# frozen_string_literal: true

class JobApplicationsController < BaseController
  before_action :authorize_user
  before_action :find_job, only: [:new, :create]
  before_action :find_job_application, only: [:show, :accept, :reject, :destroy]

  def index
    @job_applications = JobApplication.ordered.page(params[:page])
  end

  def show; end

  def new
    @job_application = @job.job_applications.new
  end

  def create
    @job_application = @job.job_applications.new(application_params)
    if @job_application.save

      redirect_to for_student_jobs_path, notice: 'Thank you for submitting application.We will contact you within a week!'
    else
      flash[:alert] = @job_application.errors.full_messages.to_sentence
      render :new
    end
  end

  def accept
    @job_application.accepted!

    redirect_to job_application_path(@job_application),  notice: 'Application accepted!'
  end

  def reject
    @job_application.rejected!

    redirect_to job_application_path(@job_application),  alert: 'Application rejected!'
  end

  def destroy
    flash[:notice] = 'Job Application is deleted' if @job_application.destroy

    redirect_to job_applications_path
  end

  private

  def authorize_user
    authorize :job_application
  end

  def find_job_application
    @job_application = JobApplication.find_by(id: params[:id])
  end

  def find_job
    @job = Job.find_by(slug: params[:job_id])
  end

  def application_params
    params.require(:job_application).permit(:student_id, :phone, :cover_letter, :resume)
  end
end


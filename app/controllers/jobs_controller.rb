class JobsController < ApplicationController
  before_action :find_job, only: [:show, :edit, :update, :destroy]

  def show; end

  def new
    @job = Job.new
    @company = current_user.company
  end

  def create
    @job = Job.new(job_params)
    @company = Company.find(params[:company_id])
    @job.company = @company
    if @job.save
      redirect_to job_path(@job)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @job.update(job_params)
      redirect_to job_path(@job)
    else
      render 'edit'
    end
  end

  def destroy
    @job.destroy
    redirect_to dashboard_path
  end

  private

  def job_params
    params.require(:job).permit(:job_title, :job_desciption, :active, :company, :location, :remote, :start_date, :duration)
  end

  def find_job
    @job = Job.find(params[:id])
  end
end

class JobsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :find_job, only: [:show, :edit, :update, :destroy]

  def show
    authorize @job
    @questions = @job.questions
    authorize @questions
    @developer_application = current_user.developer.applications.where(job: @job).first if current_user && current_user.developer
  end

  def new
    @job = Job.new
    @company = current_user.company
    authorize @job
  end

  def create
    @job = Job.new(job_params)
    @company = Company.find(params[:company_id])
    @job.company = @company
    authorize @job

    Question::DEFAULT_QUESTIONS.each do |question|
      @question = Question.new(content: question)
      @question.job = @job
      @question.save
      @job.questions << @question
    end

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
    params.require(:job).permit(:job_title, :job_description, :active, :company, :location, :remote, :start_date, :duration)
  end

  def find_job
    @job = Job.find(params[:id])
    authorize @job
  end
end

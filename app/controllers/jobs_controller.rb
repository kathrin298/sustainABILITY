class JobsController < ApplicationController
  before_action :find_job, only: [:show, :edit, :update, :destroy]

  def show
    skip_authorization
    @questions = @job.questions
  end

  def new
    @job = Job.new
    @company = current_user.company
    skip_authorization
  end

  def create
    skip_authorization
    @job = Job.new(job_params)
    @company = Company.find(params[:company_id])
    @job.company = @company

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

  def edit
    skip_authorization
  end

  def update
    skip_authorization
    if @job.update(job_params)
      redirect_to job_path(@job)
    else
      render 'edit'
    end
  end

  def destroy
    skip_authorization
    @job.destroy
    redirect_to dashboard_path
  end

  private

  def job_params
    params.require(:job).permit(:job_title, :job_description, :active, :company, :location, :remote, :start_date, :duration)
  end

  def find_job
    @job = Job.find(params[:id])
  end
end

class ApplicationsController < ApplicationController
  before_action :find_application, only: [:show, :update]

  def show
    @questions = @application.job.questions
  end

  def new
    @application = Application.new
    authorize @application
    @job = Job.find(params[:job_id])
    authorize @job
    @answer = Answer.new
  end

  def create
    @application = Application.new
    authorize @application
    @job = Job.find(params[:job_id])
    authorize @application
    @application.job = @job
    @application.developer = current_user.developer
    if @application.save
      redirect_to application_path(@application)
    else
      render 'new'
    end
  end

  def update
    authorize @application
    @application.update(application_params)
    redirect_to application_path(@application)
  end

  private

  def application_params
    params.require(:application).permit(:status)
  end

  def find_application
    @application = Application.find(params[:id])
    authorize @application
  end
end

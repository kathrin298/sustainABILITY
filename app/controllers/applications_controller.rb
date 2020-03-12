class ApplicationsController < ApplicationController
  before_action :find_application, only: [:show, :update]

  def show
    @questions = @application.job.questions
  end

  def new
    @application = Application.new
    authorize @application
    @job = Job.find(params[:job_id])
    @answer = Answer.new
  end

  def create
    @application = Application.new
    authorize @application
    @job = Job.find(params[:job_id])
    @application.job = @job
    @application.developer = current_user.developer
    if @application.save
      redirect_to application_path(@application)
    else
      render 'new'
    end
  end

  def update; end

  private

  def find_application
    @application = Application.find(params[:id])
    authorize @application
  end
end

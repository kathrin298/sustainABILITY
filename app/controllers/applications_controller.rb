class ApplicationsController < ApplicationController
  before_action :find_application, only: [:show, :update]

  def show
    skip_authorization
    @questions = @application.job.questions
  end

  def new
    skip_authorization
    @application = Application.new
    @job = Job.find(params[:job_id])
    @answer = Answer.new
  end

  def create
    skip_authorization
    @application = Application.new
    @job = Job.find(params[:job_id])
    @application.job = @job
    @application.developer = current_user.developer
    if @application.save
      redirect_to application_path(@application)
    else
      render 'new'
    end
  end

  def update
    skip_authorization

  end

  private

  def find_application
    @application = Application.find(params[:id])
  end
end

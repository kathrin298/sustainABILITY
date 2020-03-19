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
    if @application.status == 'accepted'
      if Conversation.between(@application.developer, @application.job.company).present?
        @conversation = Conversation.between(@application.developer, @application.job.company).first
      else
        @conversation = Conversation.create(developer: @application.developer, company: @application.job.company)
      end
      @message = Message.new(content: "Thank you for your application. We're happy to tell you that we accepted it and look forward to working with you!", user: current_user, conversation: @conversation)
      @message.save
      redirect_to conversations_path
    elsif @application.status == 'rejected'
      if Conversation.between(@application.developer, @application.job.company).present?
        @conversation = Conversation.between(@application.developer, @application.job.company).first
      else
        @conversation = Conversation.create(developer: @application.developer, company: @application.job.company)
      end
      @message = Message.new(content: 'Thank you for your application. We are sorry to inform you that we had to reject it. All the best for your future endeavours!', user: current_user, conversation: @conversation)
      @message.save
      redirect_to conversations_path
    end
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

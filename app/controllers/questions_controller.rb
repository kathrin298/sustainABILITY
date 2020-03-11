class QuestionsController < ApplicationController
  before_action :find_question, only: [:edit, :update, :destroy]

  def new
    skip_authorization
    @question = Question.new
    @job = Job.find(params[:job_id].to_i)
  end

  def create
    skip_authorization
    @question = Question.new(question_params)
    @job = Job.find(params[:job_id].to_i)
    @question.job = @job

    if @question.save
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
    if @question.update(question_params)
      redirect_to job_path(@question.job)
    else
      render 'edit'
    end
  end

  def destroy
    skip_authorization
    @question.destroy
    redirect_to job_path(@question.job)
  end

  private

  def question_params
    params.require(:question).permit(:content, :job)
  end

  def find_question
    @question = Question.find(params[:id])
  end
end

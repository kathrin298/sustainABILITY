class AnswersController < ApplicationController

  def create
    questions_params = params[:question]
    questions_params.each do |key, value|
      @question = Question.find(key.to_i)
      @answer = Answer.new(content: value, question: @question, developer: current_user.developer)
      @answer.save
    end
    authorize @answer
    redirect_to dashboard_path
  end
end

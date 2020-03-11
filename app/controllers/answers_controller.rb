class AnswersController < ApplicationController

  def create
    skip_authorization
    questions_params = params[:question]
    questions_params.each do |key, value|
      @question = Question.find(key.to_i)
      @answer = Answer.new(content: value, question: @question, developer: current_user.developer)
      @answer.save
    end
    redirect_to dashboard_path
  end
end

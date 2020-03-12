class ReviewsController < ApplicationController
  before_action :find_application

  def new
    skip_authorization
    @review = Review.new
  end

  def create
    skip_authorization
    @review = Review.new(review_params)
    @review.application = @application
    if @review.save
      redirect_to developer_path(@application.developer)
    else
      render 'new'
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :content, :rating)
  end

  def find_application
    @application = Application.find(params[:application_id])
  end
end

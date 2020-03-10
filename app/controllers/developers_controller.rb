class DevelopersController < ApplicationController
  before_action :find_developer, only: [:show, :edit, :update, :destroy]

  def index
    @developers = Developer.all
  end

  def show; end

  def new
    @developer = Developer.new
  end

  def create
    @developer = Developer.new(developer_params)
    @developer.user = current_user
    if @developer.save
      redirect_to developer_path(@developer)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @developer.update(developer_params)
      redirect_to developer_path(@developer)
    else
      render 'edit'
    end
  end

  def destroy
    @developer.destroy
    redirect_to destroy_user_session_path
  end

  private

  def developer_params
    params.require(:developer).permit(:first_name, :last_name, :location, :bio, :slogan, :interests, :hireable, :websites, :social_links, :user, :github_profile_url)
  end

  def find_developer
    @developer = Developer.find(params[:id])
  end
end

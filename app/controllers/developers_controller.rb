require 'open-uri'

class DevelopersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_developer, only: [:show, :edit, :update, :destroy]

  def index
    @developers = policy_scope(Developer).order(created_at: :desc)
    @available_developers = []
    Developer.where(hireable:'Currently available').each do |developer|
      @available_developers << developer
    end
    Developer.where(hireable:'Open to offers').each do |developer|
      @available_developers << developer
    end
  end

  def show
    @hired_jobs = []
    @developer.applications.where(status: 'accepted').each do |application|
      @hired_jobs << application.job
    end
    @reviews = @developer.reviews
  end

  def new
    @developer = Developer.new
    authorize @developer
  end

  def create
    @developer = Developer.new(developer_params)
    authorize @developer
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
    # if @developer.github && !@developer.github.blank?
    #   @developer.github_public_repos = JSON.parse(open('https://api.github.com/users/johnckealy/repos').read).size
    # end
  end

  def destroy; end

  private

  def developer_params
    params.require(:developer).permit(:first_name, :last_name,  :photo, :location, :bio, :slogan, :interests,
                                      :hireable, :websites, :social_links, :user, :github_profile_url)
  end

  def find_developer
    @developer = Developer.find(params[:id])
    authorize @developer
  end
end

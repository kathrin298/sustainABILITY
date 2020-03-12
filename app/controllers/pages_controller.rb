class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def dashboard
    @company = current_user.company
    @jobs = Job.where(company: @company)
    @applications = Application.where(developer: current_user.developer)
    @developers = []
    Application.where(status:'accepted', job: @jobs).each do |application|
      @developers << application.developer
      @developers.flatten
    end
  end

  def search
    if params[:query].blank?
      @results = Company.all
    else
      sql_query = "name ILIKE :query OR industry ILIKE :query"
      @results = Company.where(sql_query, query: "%#{params[:query]}%")
    end
    skip_authorization
  end
end

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :search]

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
    if params[:search_type] == 'dev_location'
      @results = query(Developer, params[:query], 'location', 'bio', 'last_name')
    elsif params[:search_type] == 'company_location'
      @results = query(Company, params[:query], 'location', 'bio', 'industry')
    elsif params[:search_type] == 'Developers'
      @results = query(Developer, params[:query], 'first_name', 'last_name', 'bio')
    elsif params[:search_type] == 'Companies'
      @results = query(Company, params[:query], 'name', 'bio', 'industry')
    elsif params[:search_type] == 'company_skills'
      @results = query(Company, params[:query], 'mission', 'bio', 'industry')
    elsif params[:search_type] == 'dev_interests'
      @results = query(Developer, params[:query], 'interests', 'bio', 'last_name')
    elsif params[:search_type] == 'company_mission'
      @results = query(Company, params[:query], 'mission', 'bio', 'name')
    elsif params[:search_type] == 'Jobs'
      @results = query(Job, params[:query], 'job_title', 'job_description', 'location')
    else
      @results = query(Developer, params[:query], 'location', 'bio', 'last_name')
    end
    serp_headline
  end

  def serp_headline
    if params[:search_type] == 'Companies'
      if params[:query] == ""
        @serp_headline = "All companies"
      else
        @serp_headline = "#{ActionController::Base.helpers.pluralize(@results.size, 'company')} matching #{params[:query]}"
      end
    elsif params[:search_type] == 'Jobs'
      if params[:query] == ""
        @serp_headline = "All jobs"
      else
        @serp_headline = "#{ActionController::Base.helpers.pluralize(@results.size, 'job')} matching #{params[:query]}"
      end
    else
      if params[:query] == ""
        @serp_headline = "All developers"
      else
        @serp_headline = "#{ActionController::Base.helpers.pluralize(@results.size, 'developer')} matching #{params[:query]}"
      end
    end
  end

  private

  def query(model, query, field1, field2, field3)
    if query.blank?
      results = model.all
    else
      sql_query = "#{field1} ILIKE :query OR #{field2} ILIKE :query OR #{field3} ILIKE :query"
      results = model.where(sql_query, query: "%#{query}%")
    end
    return results
  end
end

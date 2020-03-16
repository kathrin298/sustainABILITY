class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :search]

  def home
  end

  def dashboard
    @company = current_user.company
    @jobs = Job.where(company: @company)
    @applications = Application.where(developer: current_user.developer)
    @developer = current_user.developer
    @developer_jobs = []
    Application.where(status:'accepted', developer: @developer).each do |application|
      @developer_jobs << application.job
    end
    @developers = []
    Application.where(status:'accepted', job: @jobs).each do |application|
      @developers << application.developer
      @developers.flatten
    end
    @received_applications = []
    @jobs.each do |job|
      job.applications.each do |application|
        @received_applications << application if application.status == 'pending'
      end
    end
  end

  def search
    if params[:search_type] == 'dev_location'
      @results = query_devs(params[:query], 'location', 'bio', 'last_name')
    elsif params[:search_type] == 'company_location'
      @results = query_companies(params[:query], 'location', 'bio', 'industry')
    elsif params[:search_type] == 'Developers'
      @results = query_devs(params[:query], 'first_name', 'last_name', 'bio')
    elsif params[:search_type] == 'Companies'
      @results = query_companies(params[:query], 'name', 'bio', 'industry')
    elsif params[:search_type] == 'company_skills'
      @results = query_companies(params[:query], 'mission', 'bio', 'industry')
    elsif params[:search_type] == 'dev_interests'
      @results = query_devs(params[:query], 'interests', 'bio', 'last_name')
    elsif params[:search_type] == 'company_mission'
      @results = query_companies(params[:query], 'mission', 'bio', 'name')
    else
      @results = query_devs(params[:query], 'location', 'bio', 'last_name')
    end
  end

  private

  def query_companies(query, field1, field2, field3)
    if query.blank?
      results = Company.all
    else
      sql_query = "#{field1} ILIKE :query OR #{field2} ILIKE :query OR #{field3} ILIKE :query"
      results = Company.where(sql_query, query: "%#{query}%")
    end
    return results
  end

  def query_devs(query, field1, field2, field3)
    if query.blank?
      results = Developer.all
    else
      sql_query = "#{field1} ILIKE :query OR #{field2} ILIKE :query OR #{field3} ILIKE :query"
      results = Developer.where(sql_query, query: "%#{query}%")
    end
    return results
  end
end

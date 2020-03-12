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
    if params[:search_type] == 'dev_location'
      @results = query_devs(params[:query], 'location', 'bio' 'last_name')
    elsif params[:search_type] == 'company_location'
      @results = query_companies(params[:query], 'location', 'bio', 'industry')
    elsif params[:search_type] == 'developer'
      @results = query_devs(params[:query], 'first_name', 'last_name', 'bio')
    elsif params[:search_type] == 'company'
      @results = query_companies(params[:query], 'name', 'bio', 'industry')
    end
  end

  private

  def query_companies(query, field1, field2)
    if query.blank?
      results = Company.all
    else
      sql_query = "#{field1} ILIKE :query OR #{field2} ILIKE :query"
      results = Company.where(sql_query, query: "%#{query}%")
    end
    return results
  end

  def query_devs(query, field1, field2, field3)
    if query.blank?
      results = Developer.all
    else
      sql_query = "#{field1} ILIKE :query OR #{field2} ILIKE :query"
      results = Developer.where(sql_query, query: "%#{query}%")
    end
    return results
  end
end

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
  end


  def search
    if params[:search_type] == 'dev_location'
      if params[:query].blank?
        @results = Developer.all
      else
        @results = Developer.search_dev_by_location(params[:query])
      end
    elsif params[:search_type] == 'company_location'
      if params[:query].blank?
        @results = Company.all
      else
        @results = Company.search_companies_by_location(params[:query])
      end
    elsif params[:search_type] == 'Developers'
      if params[:query].blank?
        @results = Developer.all
      else
        @results = Developer.search_all_developers(params[:query])
      end
    elsif params[:search_type] == 'Companies'
      if params[:query].blank?
        @results = Company.all
      else
        @results = Company.search_all_companies(params[:query])
      end
    elsif params[:search_type] == 'dev_interests'
      if params[:query].blank?
        @results = Developer.all
      else
        @results = Developer.search_dev_by_interests(params[:query])
      end
    elsif params[:search_type] == 'company_mission'
      if params[:query].blank?
        @results = Company.all
      else
        @results = Company.search_companies_by_mission(params[:query])
      end
    elsif params[:search_type] == 'Jobs'
      if params[:query].blank?
        @results = Job.all
      else
        @results = Job.search_all_jobs(params[:query])
      end
    elsif params[:search_type] == 'Skills'
      if params[:query].blank?
        Developer.all
      else
        @results = []
        skills = Skill.search_jobs_by_skill(params[:query])
        # skills = query(Skill, params[:query], 'name', 'name', 'name')
        skills.each do |skill|
          skill.developer_skills.each do |dev_skill|
            @results << dev_skill.developer
          end
        end
        @results = @results.uniq
      end
    else
      @results = Developer.all
    end
    serp_headline
  end

  def serp_headline
    if params[:search_type] == 'Companies'
      @serp_headline = serp_headline_helper('company')
    elsif params[:search_type] == 'Jobs'
      @serp_headline = serp_headline_helper('jobs')
    elsif params[:search_type] == 'company_location'
      @serp_headline = serp_headline_helper('company')
    elsif params[:search_type] == 'company_mission'
      @serp_headline = serp_headline_helper('company')
    else
      @serp_headline = serp_headline_helper('developer')
    end
  end

  private

  def serp_headline_helper(term)
    term = ActionController::Base.helpers.pluralize(@results.size, term)
    if params[:query] == ""
      return "All #{term}"
    else
      return "#{term} matching '#{params[:query]}'"
    end
  end


  # def query(model, query, field1, field2, field3)
  #   if query.blank?
  #     results = model.all
  #   else
  #     sql_query = "#{field1} ILIKE :query OR #{field2} ILIKE :query OR #{field3} ILIKE :query"
  #     results = model.where(sql_query, query: "%#{query}%")
  #   end
  #   return results
  # end
end

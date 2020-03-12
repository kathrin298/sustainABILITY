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
end

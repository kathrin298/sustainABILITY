class CompaniesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_company, only: [:show, :edit, :destroy, :update]

  def index
    @companies = policy_scope(Company).order(created_at: :desc)
    @jobs = policy_scope(Job).order(created_at: :desc)
    @available_jobs = []
    Job.where(active: true).map { |job| @available_jobs << job }
  end

  def show; end

  def new
    @company = Company.new
    authorize @company
  end

  def create
    @company = Company.new(company_params)
    authorize @company
    @company.user = current_user
    if @company.save
      redirect_to company_path(@company)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @company.update(company_params)
      redirect_to company_path(@company)
    else
      render 'edit'
    end
  end

  def destroy
    @company.destroy
    redirect_to companies_path
  end

  private

  def company_params
    params.require(:company).permit(:name, :photo, :location, :user, :photo, :mission, :employees, :industry, :bio, :website, :video_url)
  end

  def find_company
    @company = Company.find(params[:id])
    authorize @company
  end
end

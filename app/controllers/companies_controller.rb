class CompaniesController < ApplicationController
  before_action :find_company, only: [:show, :edit, :destroy, :update]

  def index
    @companies = Company.all
    @companies = policy_scope(Company).order(created_at: :desc)
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
    params.require(:company).permit(:name, :location, :user, :photo, :mission, :employees, :industry, :bio, :website, :video_url)
  end

  def find_company
    @company = Company.find(params[:id])
  end
end

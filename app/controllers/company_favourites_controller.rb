class CompanyFavouritesController < ApplicationController

  def create
    @company = Company.find(params[:company_id])
    @company_favourite = CompanyFavourite.new
    @company_favourite.company = @company
    @company_favourite.developer = current_user.developer
    if @company_favourite.save
      redirect_to company_path(@company)
    else
      render "company/show"
    end
  end

  def destroy
    @favourite = CompanyFavourite.find(params[:id])
    @favourite.destroy
    redirect_to dashboard_path
  end

end

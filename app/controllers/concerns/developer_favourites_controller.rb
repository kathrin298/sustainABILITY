class DeveloperFavouritesController < ApplicationController
  def create
    @developer = Developer.find(params[:developer_id])
    @developer_favourite = DeveloperFavourite.new
    @developer_favourite.developer = @developer
    @developer_favourite.company = current_user.company
    if @developer_favourite.save
      redirect_to developer_path(@developer)
    else
      render "developers/show"
    end
  end

  def destroy
    @favourite = DeveloperFavourite.find(params[:id])
    @favourite.destroy
    redirect_to dashboard_path
  end
end

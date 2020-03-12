class DeveloperSkillsController < ApplicationController
  before_action :find_developer

  def new
    @developer_skill = DeveloperSkill.new
  end

  def create
    @developer_skill = DeveloperSkill.new(developer_skill_params)
    @developer_skill.developer = @developer
    if @developer_skill.save
      redirect_to developer_path(@developer)
    else
      render 'new'
    end
  end

  def destroy
    @developer_skill = DeveloperSkill.find(params[:id])
    @developer_skill.destroy
    redirect_to developer_path(@developer)
  end

  private

  def developer_skill_params
    params.require(:developer_skill).permit(:skill_id)
  end

  def find_developer
    @developer = Developer.find(params[:developer_id])
  end
end

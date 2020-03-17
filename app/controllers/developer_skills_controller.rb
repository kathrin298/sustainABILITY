class DeveloperSkillsController < ApplicationController
  before_action :find_developer

  def new
    @developer_skill = DeveloperSkill.new
  end

  def create
    params[:developer_skill][:skill_id].each do |item|
      if item =~ /\d/
        @developer_skill = DeveloperSkill.new(skill_id: item.to_i, developer: @developer)
        @developer_skill.save
      elsif item =~ /\w/
        @skill = Skill.new(name: item)
        @developer_skill = DeveloperSkill.new(skill: @skill, developer: @developer)
        @developer_skill.save
      end
    end
    redirect_to developer_path(@developer)
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

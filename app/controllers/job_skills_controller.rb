class JobSkillsController < ApplicationController
  before_action :find_job

  def new
    skip_authorization
    @job_skill = JobSkill.new
  end

  def create
    skip_authorization
    params[:job_skill][:skill_id].each do |item|
      if item =~ /\d/
        @job_skill = JobSkill.new(skill_id: item.to_i, job: @job)
        @job_skill.save
      elsif item =~ /\w/
        @skill = Skill.new(name: item)
        @job_skill = JobSkill.new(skill: @skill, job: @job)
        @job_skill.save
      end
    end
    redirect_to job_path(@job)
  end

  def destroy
    skip_authorization
    @job_skill = JobSkill.find(params[:id])
    @job_skill.destroy
    redirect_to job_path(@job)
  end

  private

  def job_skill_params
    params.require(:job_skill).permit(:skill_id)
  end

  def find_job
    @job = Job.find(params[:job_id])
  end
end

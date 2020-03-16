class JobSkillsController < ApplicationController
  before_action :find_job

  def new
    skip_authorization
    @job_skill = JobSkill.new
  end

  def create
    skip_authorization
    @job_skill = JobSkill.new(job_skill_params)
    @job_skill.job = @job
    if @job_skill.save
      redirect_to job_path(@job)
    else
      render 'new'
    end
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

class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :application
  belongs_to :developer
  validates :content, presence: true

  before_validation :create_application

  private

  def create_application
    question = Question.find(self.question_id)
    job = Job.find(question.job.id)
    application = Application.find_or_create_by(job: job, developer: self.developer)
    self.application = application
  end
end

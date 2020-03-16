class Job < ApplicationRecord
  START_DATES = ["ASAP", "This month", "Flexible"]
  DURATIONS = ["< 1 Month", "1–3 Months", "3–6 Months", "6 Months+"]
  REMOTE = ['Yes', 'No']

  belongs_to :company
  has_many :questions, dependent: :destroy
  has_many :answers, through: :questions, dependent: :destroy
  has_many :applications, dependent: :destroy
  has_many :job_skills, dependent: :destroy
  has_many :skills, through: :job_skills, dependent: :destroy

  validates :job_title, :job_description, presence: true
end

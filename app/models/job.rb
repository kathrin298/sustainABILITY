class Job < ApplicationRecord
  START_DATES = ["ASAP", "This month", "Flexible"]
  DURATIONS = ["< 1 Month", "1–3 Months", "3–6 Months", "6 Months+"]
  REMOTE = ['Yes', 'No']

  belongs_to :company
  has_many :questions, dependent: :destroy

  validates :job_title, :job_description, presence: true
end

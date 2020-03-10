class Job < ApplicationRecord
  START_DATES = ["ASAP", "This month", "Flexible"]
  DURATIONS = ["< 1 Month", "1–3 Months", "3–6 Months", "6 Months+"]

  belongs_to :company
  has_many :questions, dependent: :destroy
end

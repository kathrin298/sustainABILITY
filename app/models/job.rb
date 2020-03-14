class Job < ApplicationRecord
  START_DATES = ["ASAP", "This month", "Flexible"]
  DURATIONS = ["< 1 Month", "1–3 Months", "3–6 Months", "6 Months+"]
  REMOTE = ['Yes', 'No']

  belongs_to :company
  has_many :questions, dependent: :destroy
  has_many :answers, through: :questions, dependent: :destroy
  has_many :applications, dependent: :destroy

  validates :job_title, :job_description, presence: true


  def posted_how_long_ago
    minutes_ago = (Time.zone.now - self.updated_at)/60
    if minutes_ago > 60
      return "Posted #{(minutes_ago/60).to_i} hours ago"
    elsif minutes_ago > 24*60
      return "Posted #{(minutes_ago/(24*60)).to_i} days ago"
    else
      return "Posted #{minutes_ago.to_i} minutes ago"
    end
  end
end

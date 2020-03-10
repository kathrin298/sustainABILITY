class Question < ApplicationRecord
  DEFAULT_QUESTIONS = ["Why do want to work for our company?",
                       "What skills can you bring to this project?"]
                       "What are your personal development goals?" ]

  belongs_to :job
  validates :content, presence: true
  has_many :answers
end

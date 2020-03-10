class Question < ApplicationRecord
  belongs_to :job
  validates :content, presence: true
  has_many :answers
end

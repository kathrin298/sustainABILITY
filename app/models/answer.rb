class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :application
  validates :content, presence: true
end

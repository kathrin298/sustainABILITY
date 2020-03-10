class Review < ApplicationRecord
  belongs_to :application

  validates :rating, presence: true
end

class Application < ApplicationRecord
  STATUS = ['pending', 'accepted', 'rejected']
  belongs_to :developer
  belongs_to :job
  has_many :answers, dependent: :destroy
  has_one :review, dependent: :destroy
  has_many :questions, through: :jobs

  validates :status, inclusion: [ in: STATUS]
end

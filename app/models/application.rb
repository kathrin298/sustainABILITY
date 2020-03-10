class Application < ApplicationRecord
  STATUS = ['pending', 'accepted', 'rejected']
  belongs_to :developer
  belongs_to :job
  has_many :answers
  has_one :review

  validates :status, inclusion: [ in: STATUS]
end

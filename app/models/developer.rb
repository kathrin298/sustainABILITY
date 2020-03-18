class Developer < ApplicationRecord
  HIREABLE_OPTIONS = ['Currently available', 'Open to offers', 'Not available']
  belongs_to :user
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_all_developers,
    against: [ :last_name,  :first_name,  :interests,  :bio, :slogan ],
    associated_against: {
      skills: [ :name ]
    },
    using: {
      tsearch: { prefix: true }
    }

  pg_search_scope :search_dev_by_location,
    against: [ :location ],
    using: {
      tsearch: { prefix: true }
    }

  pg_search_scope :search_dev_by_interests,
    against: [ :interests, :bio, :slogan ],
    using: {
      tsearch: { prefix: true }
    }

  has_many :company_favourites, dependent: :destroy
  has_many :favourites, through: :company_favourites, source: :company
  has_many :developer_skills, dependent: :destroy
  has_many :skills, through: :developer_skills, dependent: :destroy

  has_many :conversations
  has_many :messages, through: :conversations

  has_many :answers
  has_many :applications
  has_many :reviews, through: :applications

  validates :first_name, :last_name, presence: true
  validates :hireable, inclusion: { in: HIREABLE_OPTIONS }, presence: true

  def average_rating
    if !reviews.empty?
      (reviews.sum(:rating) / reviews.size.to_f).round(1)
    else
      "no reviews yet"
    end
  end


end


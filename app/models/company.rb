class Company < ApplicationRecord
  INDUSTRIES = ["Agriculture", "Banking & Finance", "Clothing & Textiles",
                "Consumer Products", "Education", "Energy", "Food",
                "Foreign Policy", "Health", "Law", "Non-profits",
                "Research",  "Sport", "Tourism", "Transport", "Waste Management", "Other"]

  belongs_to :user
  has_one_attached :photo

  has_many :jobs, dependent: :destroy

  has_many :developer_favourites, dependent: :destroy
  has_many :favourites, through: :developer_favourites, source: :developer

  has_many :conversations
  has_many :messages, through: :conversations

  # validates :photo, presence: true
  validates :name, :mission, :industry, presence: true

  include PgSearch::Model
  pg_search_scope :search_all_companies,
    against: [ :name, :mission, :industry, :bio ],
    using: {
      tsearch: { prefix: true }
    }

  pg_search_scope :search_companies_by_location,
    against: [ :location ],
    using: {
      tsearch: { prefix: true }
    }


  pg_search_scope :search_companies_by_mission,
    against: [ :mission, :bio, :industry ],
    using: {
      tsearch: { prefix: true }
    }
end

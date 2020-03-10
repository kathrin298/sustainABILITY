class Company < ApplicationRecord
  INDUSTRIES = ["Agriculture", "Banking & Finance", "Clothing & Textiles",
                "Consumer Products", "Education", "Energy", "Food",
                "Foreign Policy", "Health", "Law", "Non-profits",
                "Research",  "Sport", "Tourism", "Transport", "Waste Management", "Other"]

  belongs_to :user
  # has_one_attached :photo

  has_many :jobs, dependent: :destroy

  has_many :company_favourites, dependent: :destroy
  has_many :developer_favourites, dependent: :destroy

  # validates :photo, presence: true
  validates :name, :mission, :industry, presence: true

  has_many :conversations
  has_many :messages, through: :conversations
end

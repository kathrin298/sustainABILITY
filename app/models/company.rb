class Company < ApplicationRecord
  belongs_to :user
  has_one_attached :photos

  has_many :company_favourites
  has_many :developer_favourites

  validates :photos, :name, :mission, :industry, presence: true

end

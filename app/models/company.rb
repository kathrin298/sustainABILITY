class Company < ApplicationRecord
  belongs_to :user
  has_one_attached :photos

  has_many :jobs, dependent: :destroy

  has_many :company_favourites, dependent: :destroy
  has_many :developer_favourites, dependent: :destroy

  validates :photos, :name, :mission, :industry, presence: true

end

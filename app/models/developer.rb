class Developer < ApplicationRecord
  HIREABLE_OPTIONS = ['Currently available', 'Open to offers', 'Not available']
  belongs_to :user

  has_many :applications, dependent: :destroy
  has_many :reviews, through: :applications, dependent: :destroy
  has_many :jobs, through: :applications, dependent: :destroy
  has_many :answers, through: :applications, dependent: :destroy

  has_many :conversations, dependent: :destroy
  has_many :messages, through: :conversations, dependent: :destroy

  has_many :company_favourites, dependent: :destroy
  has_many :developer_favourites, dependent: :destroy

  has_many :developer_skills, dependent: :destroy
  has_many :skills, through: :developer_skills, dependent: :destroy

  validates :first_name, :last_name, presence: true
  validates :hireable, inclusion: { in: HIREABLE_OPTIONS }, presence: true

  def social_icon(social_link)
     # should return some html code(?) based on the return of a regex
     # that finds which social site the list object belongs to
  end

end


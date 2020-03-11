class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :developer, dependent: :destroy
  has_one :company, dependent: :destroy
  has_many :messages

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end

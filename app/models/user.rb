class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :developer, dependent: :destroy
  has_one :company, dependent: :destroy
  has_many :messages

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      dev = Developer.new(first_name: auth.info.name.split[0],
                          last_name: auth.info.name.split[-1],
                          location: auth.extra.raw_info.location,
                          hireable: "Currently available",
                          website: auth.info.urls.Blog,
                          bio: "",
                          slogan: "",
                          github: auth.info.urls.GitHub,
                          interests: "",
                          facebook: "",
                          twitter: "",
                          linkedin: "",
                          github_username: auth.info.nickname)
      dev.user = user
      dev.save
    end

  end

  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
  #       user.email = data["email"] if user.email.blank?
  #     end
  #   end
  # end

  def type; end
end

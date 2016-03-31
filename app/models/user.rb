class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  validates :username, presence: true, uniqueness: true, length: { minimum: 4,
maximum: 16 }
  validates :first_name, presence: true, length: { minimum: 2,
  maximum: 16 }
  validates :last_name, presence: true, length: { minimum: 2,
  maximum: 16 }

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
        user.first_name = data['first_name'] if user.first_name.blank?
        user.last_name = data['last_name'] if user.last_name.blank?
        user.image_url = data['picture']['data']['url'] if user.image_url.blank?
        user.provider = session['devise.facebook_data']['provider'] if user.provider.blank?
        user.uid = session['devise.facebook_data']['uid'] if user.uid.blank?
      end
    end
  end


  def self.from_omniauth(auth)
    puts auth
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.username = auth.info.nickname
      user.password = Devise.friendly_token[0,20]
      user.image_url = auth.info.image # assuming the user model has an image
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
    end
  end
end

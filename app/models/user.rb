class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  devise :omniauthable, omniauth_providers: %i[facebook]
  
  after_create :send_welcome_email


  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name   # assuming the user model has a name
       # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  
def send_welcome_email
    UserMailer.welcome_email(self).deliver_now  
end

 followability
 
 has_one_attached :avatar
 has_many :notifications, as: :recipient, dependent: :destroy
 has_many :posts, foreign_key: :user_id, dependent: :destroy
 has_many :likes, dependent: :destroy
 has_many :comments
  def unfollow(user)
    followerable_relationships.where(followable_id: user.id).destroy_all
  end

end

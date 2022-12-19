class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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

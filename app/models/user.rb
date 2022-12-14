class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 followability

 has_many :notifications, as: :recipient, dependent: :destroy
  
  def unfollow(user)
    followerable_relationships.where(followable_id: user.id).destroy_all
  end

end

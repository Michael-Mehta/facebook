class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments

  def liked?(user)

    !!self.likes.find{|like| like.user_id == user.id}
  end
end

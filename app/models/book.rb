class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  scope :latest ,-> {order("created_at DESC")}
  scope :rated ,-> {order("rate DESC")}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end

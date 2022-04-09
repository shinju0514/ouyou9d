class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_many :tags, through: :book_tags
  has_many :book_tags, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  scope :latest ,-> {order("created_at DESC")}
  scope :rated ,-> {order("rate DESC")}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def save_tags(save_book_tags)
    # 登録されているタグを取得
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    # 古いタグを取得（登録されているタグ - フォームから新規に送られてきたタグ）
    old_tags = current_tags - save_book_tags
    # 新しいタグの取得（フォームから新規に送られてきたタグ - 登録されているタグ）
    new_tags = save_book_tags - current_tags

    old_tags.each do |old_name|
    # 古いタグを削除
      self.tags.delete Tag.find_by(tag_name: old_name)
    end

    new_tags.each do |new_name|
    # 新しいタグがテーブルに存在しなければ新規登録
      book_tag = Tag.find_or_create_by(tag_name: new_name)
      self.tags << book_tag
    end
  end
end


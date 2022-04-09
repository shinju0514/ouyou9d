class Tag < ApplicationRecord
  has_many :tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :books, through: :tag_maps
  has_many :books, through: :book_tags
  has_many :book_tags, dependent: :destroy
end

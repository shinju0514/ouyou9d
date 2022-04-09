class BookCategory < ApplicationRecord
  belongs_to :book_params
  belongs_to :category
  validates :book_id, presence:true
  validates :category_id, presence:true
end

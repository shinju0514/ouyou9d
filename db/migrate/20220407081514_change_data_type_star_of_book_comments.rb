class ChangeDataTypeStarOfBookComments < ActiveRecord::Migration[6.1]
  def change
    change_column :book_comments, :star, :float
  end
end

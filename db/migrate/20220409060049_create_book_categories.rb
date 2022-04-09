class CreateBookCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :book_categories do |t|
      t.string :book_id
      t.string :category_id

      t.timestamps
    end
  end
end

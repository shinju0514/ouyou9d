class BookCommentsController < ApplicationController

  def create
    book=Book.find(params[:book_id])
    # comment=current_user.book_comments.new(book_comment_params) ストロングぱらめーたの値を()に入れる
    @book_comment=BookComment.new(book_comment_params)
    @book_comment.user_id=current_user.id
    @book_comment.book_id=book.id
    @book_comment.save
  end


  def destroy
    @book_comment=BookComment.find_by(params[:id]).destroy
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end


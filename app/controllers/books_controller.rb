class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def show
    @book_new=Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment=BookComment.new
    @book_tags = @book.tags
  end

  def index
    @book = Book.new
    @tag_list = Tag.all
    @user=current_user
    if params[(:created_at)||(:rate)]
    @books = Book.latest
    elsif
    @books = Book.rated
    else
    @books = Book.all
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    tag_list = params[:body][:tag_name]
    if@book.save
      @book.save_tag(tag_list)
      flash[:notice]="successfully"
      redirect_to book_path(@book)
    else
      @books=Book.all
      @user=current_user
      render 'index'
    end
  end

 def edit
     @book = Book.find(params[:id])
 end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book) , notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :rate, :tag_name)
  end
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end

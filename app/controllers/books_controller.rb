class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit]
  include Pagy::Backend
  def index
    @book_all = current_user.books.includes(:user).order(created_at: :desc)
    @pagy, @books = pagy(@book_all)
    rescue Pagy::OverflowError
    redirect_to root_path(page: 1)
  end

  def show

  end

  def new
    @book = Book.new
  end

  def edit
    @book.update! book_params
    redirect_to books_url, notice: "Book was successfully update."
  end

  def create
    @book = current_user.books.create! book_params
    redirect_to books_url, notice: "Book was successfully created."
  end

  private

  def book_params
    params.require(:book).permit(:name, :editable, :cover_url, :books_count).tap do |whitelisted|
      whitelisted[:words_count] = params[:words_count] || 0
    end
  end

  def set_book
    @book = current_user.books.find(params[:id])
  end

end

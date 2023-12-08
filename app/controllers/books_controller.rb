class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
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

  end

  def create
    @book = current_user.books.create! book_params
    redirect_to books_url, notice: "Book was successfully created."
  end

  def update
    if  @book.update(book_params)
      respond_to do |format|
        format.html { redirect_to books_url, notice: "Book was successfully update." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy!
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@book) }
      format.html { redirect_to books_url, notice: 'Book was delete..' }
    end
  end

  private

  def set_book
    @book = current_user.books.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:name, :editable, :cover_url)
  end

end

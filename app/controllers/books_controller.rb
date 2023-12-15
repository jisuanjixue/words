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
    @q = @book.words.includes(:book).ransack(params[:q])
    @word_all = @q.result(distinct: true).order(created_at: :desc)
    @pagy, @words = pagy(@word_all)
    rescue Pagy::OverflowError
    redirect_to book_path(@book, page: 1)
  end

  def new
    @book = Book.new
  end

  def edit

  end

  def create
    @book = current_user.books.create! book_params
    if @book
      respond_to do |format|
        format.html { redirect_to books_url, notice: "Book was successfully created." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update
    if  @book.update! book_params
      respond_to do |format|
        format.html { redirect_to books_url, notice: "Book was successfully updated." }
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
    @book = current_user.books.friendly.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:name, :editable, :cover_url)
  end

end

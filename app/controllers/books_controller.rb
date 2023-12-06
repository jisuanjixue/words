class BooksController < ApplicationController
  include Pagy::Backend
  def index
    @book_all = current_user.books.includes(:user).order(created_at: :desc)
    @pagy, @books = pagy(@book_all)
    rescue Pagy::OverflowError
    redirect_to root_path(page: 1)
  end
end

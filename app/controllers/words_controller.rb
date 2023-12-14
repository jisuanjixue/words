class WordsController < ApplicationController
  before_action :set_book
  before_action :set_word, only: %i[show edit update destroy unmastered mastered]


  def show
  end

  def new
    @word = @book.words.build
  end

  def edit
  end

  def create
    @word = @book.words.create! word_params
    if @word
      respond_to do |format|
        format.html { redirect_to book_path(@book), notice: "Word was successfully created."  }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update
    if @word.update! word_params
      respond_to do |format|
        format.html { redirect_to book_path(@book), notice: "Word was successfully updated."  }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @word
    @word.destroy!
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.remove(@word) }
        format.html { redirect_to book_path(@book), notice: 'word was delete..' }
    end
    else
      redirect_to book_path(@book), alert: '未找到该单词.'
    end
  end

  def mastered
    @word.update!(status: 1)
    redirect_to book_path(@book), notice: '单词标记已掌握'
  end

  def unmastered
    @word.update!(status: 0)
    redirect_to book_path(@book), notice: '单词标记未掌握.'
  end

  private
  def set_book
    @book = current_user.books.friendly.find(params[:book_id])
  end

  def set_word
    @word = @book.words.friendly.find_by(slug: params[:id])
  end

  def word_params
    params.require(:word).permit(:name, :definition, :example_sentence, :pronunciation, )
  end
end

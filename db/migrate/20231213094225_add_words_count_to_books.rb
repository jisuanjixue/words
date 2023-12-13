class AddWordsCountToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :words_count, :integer
  end
end

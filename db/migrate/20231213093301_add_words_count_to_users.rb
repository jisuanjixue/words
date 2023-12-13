class AddWordsCountToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :words_count, :integer
  end
end

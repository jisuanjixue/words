class AddBooksCountToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :books_count, :integer
  end
end

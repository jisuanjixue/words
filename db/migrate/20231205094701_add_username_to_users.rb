class AddUsernameToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string, null: true
  end
end

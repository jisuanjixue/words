class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :name, null: false
      t.string :cover_url, null: true
      t.integer :words_count, default: 0
      t.boolean :editable, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

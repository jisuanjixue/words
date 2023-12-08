class CreateWords < ActiveRecord::Migration[7.1]
  def change
    create_table :words do |t|
      t.string :name
      t.text :definition
      t.text :example_sentence
      t.string :pronunciation
      t.string :slug
      t.integer :status
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end

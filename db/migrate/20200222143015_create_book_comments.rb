class CreateBookComments < ActiveRecord::Migration[5.2]
  def change
    create_table :book_comments do |t|
      t.references :book, foreign_key: true
      t.text :comment, null: false
      t.integer :user_id

      t.timestamps
    end
  end
end

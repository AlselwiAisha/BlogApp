class CreatePost < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :authorId, null: false, foreign_key: true
      t.string :title
      t.text :text
      t.datetime :updateAt
      t.datetime :createAt
      t.integer :commentsCounter
      t.integer :likesCounter

      t.timestamps
    end
  end
end

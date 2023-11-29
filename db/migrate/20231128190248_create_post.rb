class CreatePost < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :author, foreign_key: { to_table: 'users' }, null: false, index: true
      t.string :title
      t.text :text
      t.datetime :update_at
      t.datetime :create_at
      t.integer :comments_counter
      t.integer :likes_counter

      t.timestamps
    end
  end
end

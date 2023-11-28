class CreateUser < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :photo
      t.text :bio
      t.datetime :updateAt
      t.datetime :createAt
      t.integer :postsCounter

      t.timestamps
    end
  end
end

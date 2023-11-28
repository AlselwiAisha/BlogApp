class CreateLike < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references :userId, null: false, foreign_key: true
      t.references :postId, null: false, foreign_key: true
      t.datetime :updateAt
      t.datetime :createAt

      t.timestamps
    end
  end
end

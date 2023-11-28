class CreateComment < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.text :text
      t.datetime :updateAt
      t.datetime :createAt

      t.timestamps
    end
  end
end

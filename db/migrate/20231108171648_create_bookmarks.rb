class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :review, null: false, foreign_key: true

      t.timestamps
    end
    # bookmarksにおいてuser_idとpost_idの組み合わせを一意性あるものにする
    add_index  :bookmarks, [:user_id, :review_id], unique: true
  end
end

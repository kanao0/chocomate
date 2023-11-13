class Bookmark < ApplicationRecord
  # ユーザー＆レビューに属する  
 belongs_to :user
 belongs_to :review
# 重複したブックマーク登録ができないようにする
 validates :user_id, uniqueness: { scope: :review_id }
end

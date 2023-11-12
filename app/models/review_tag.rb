class ReviewTag < ApplicationRecord
  # レビューに属する
  belongs_to :review
  # タグに属する
  belongs_to :tag
  # 空で登録だめ
  validates :review_id, presence: true
  validates :tag_id, presence: true  
end

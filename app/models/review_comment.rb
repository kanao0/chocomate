class ReviewComment < ApplicationRecord
  # ユーザーに属する
  belongs_to :user
  # レビューに属する
  belongs_to :review

  # 空のコメントはだめ
  validates :comment, presence: true, length: { maximum: 200 }
end

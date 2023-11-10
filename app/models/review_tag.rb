class ReviewTag < ApplicationRecord
  # レビューに属する
  belongs_to :review
  # タグに属する
  belongs_to :tag
end

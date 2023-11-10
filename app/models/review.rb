class Review < ApplicationRecord
  # ユーザーに属する
  belongs_to :user
  # 商品に属する
  belongs_to :product  
  # 1つのレビューに複数タグ付けできる、レビューが消えたらそのタグも消える
  has_many :review_tags, dependent: :destroy      
end

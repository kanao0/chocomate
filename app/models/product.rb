class Product < ApplicationRecord
  #ブランドに属する
  belongs_to :brand
  # 種類に属する
  belongs_to :type
  # 産地に属する
  belongs_to :origin
  # 1つの商品に複数レビューが書ける、レビューが消えたらその商品も消える
  has_many :reviews, dependent: :destroy
end

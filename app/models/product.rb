class Product < ApplicationRecord
  #ブランドに属する
  belongs_to :brand
  # 種類に属する
  belongs_to :type
  # 産地に属する
  belongs_to :origin
  # 1つの商品に複数レビューが書ける、レビューが消えたらその商品も消える, dependent: :destroy
  has_many :reviews
  
  # 空で登録だめ、一意性持たせる
  validates :name, presence: true, uniqueness: true
  # 空で登録だめ、0より大きい数指定
  validates :price, presence: true, numericality: { greater_than: 0 }  
end

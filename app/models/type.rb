class Type < ApplicationRecord
  # 1つの種類から複数商品が生まれる、種類が消えたら紐付く商品も消える
  has_many :products, dependent: :destroy  
end


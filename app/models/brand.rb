class Brand < ApplicationRecord
  # 1つのブランドから複数商品が、ブランドが消えたら紐付く商品も消える
  has_many :products, dependent: :destroy

  # 空で登録だめ、一意性持たせる
  validates :name, presence: true, uniqueness: true

end

class Review < ApplicationRecord
  # ユーザーに属する
  belongs_to :user
  # 商品に属する
  belongs_to :product
  # 1つのレビューに複数タグ付けできる、レビューが消えたらそのタグも消える
  has_many :review_tags, dependent: :destroy
  # 1つのレビューに複数コメントできる、レビューが消えたらそのコメントも消える
  has_many :review_comments, dependent: :destroy
  # レビュー画像
  has_one_attached :image

  # 空で登録できない
  validates :image, presence: true
  # フィールドの値(星評価)は1以上
  validates :rate, presence: true, numericality: { greater_than_or_equal_to: 1 }
  # 空で登録できない、500文字を超える本文は保存されない
  validates :body, presence: true, length: { maximum: 500 }

  # レビューイメージの設定(呼び出すとき引数必要!)
  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end
end

class Review < ApplicationRecord
  # ユーザーに属する
  belongs_to :user
  # 商品に属する
  belongs_to :product
  # 1つのレビューに複数タグ付けできる、レビューが消えたらそのタグも消える
  has_many :review_tags, dependent: :destroy
  has_many :tags, through: :review_tags
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

  def save_tag(sent_tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete(Tag.find_by(name: old))
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
   end
  end




  # レビューイメージの設定(呼び出すとき引数必要!)
  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end
end

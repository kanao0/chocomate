class Review < ApplicationRecord
  # ユーザーに属する
  belongs_to :user
  # 商品に属する
  belongs_to :product
  # 1つのレビューに複数タグ付けできる、レビューが消えたらそのタグも消える
  has_many :review_tags, dependent: :destroy
  has_many :tags, through: :review_tags
  # レビューは複数のユーザーからコメントされる、レビューが消えたらそのコメントも消える
  has_many :review_comments, dependent: :destroy
  # レビューは複数のユーザーからブックマークされる、レビューが消えたらブックマークも消える
  has_many :bookmarks, dependent: :destroy
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
      tag_to_remove = self.tags.find_by(name: old)
      self.tags.destroy(tag_to_remove) if tag_to_remove.present?
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag unless self.tags.include?(new_post_tag)
    end
  end


  # 現在ログインしているユーザーがブックマーク登録しているかどうか判断するためのメソッド
  # find_byでuser_idとuser.idが一致するbookmarksを探し、なければnilを返す
  def find_bookmark(user)
    return nil if user.nil?
      bookmarks.find_by(user_id: user.id)
  end


  # レビューイメージの設定(呼び出すとき引数必要!)
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end

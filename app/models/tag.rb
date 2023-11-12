class Tag < ApplicationRecord
  # レビューが消えたらタグも消える
  has_many :review_tags, dependent: :destroy, foreign_key: 'tag_id'   
  # タグは複数のレビューを持つ　それは、review_tagsを通じて参照できる
  has_many :reviews, through: :review_tags
  validates :name, uniqueness: true, presence: true  
end

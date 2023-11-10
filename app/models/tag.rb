class Tag < ApplicationRecord
  # 1つのタグにたいして複数のレビューがある、レビューが消えたらタグも消える
  has_many :review_tags, dependent: :destroy    
end

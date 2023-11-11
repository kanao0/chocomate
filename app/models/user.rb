class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ユーザー1人につき1つのプロフィール画像
  has_one_attached :profile_image
  # 1人のユーザーは複数のレビューを投稿できる、ユーザーが消えたらそのレビューも消える
  has_many :reviews, dependent: :destroy  
  # 1人のユーザーは複数コメントできる、ユーザーが消えたらそのコメントも消える
  has_many :review_comments, dependent: :destroy  
 
  

  # ゲストユーザーのメールアドレス
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
      user.bio = "これはゲストユーザーです"
    end
  end


  # プロフィールイメージの設定
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end  
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ユーザー1人につき1つのプロフィール画像
  has_one_attached :profile_image

  # ゲストユーザーのメールアドレス
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
      user.bio = "これはゲストユーザーです"
    end
  end



  # プロフィールイメージがないとき
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end

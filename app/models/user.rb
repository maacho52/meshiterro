class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #たくさんpost_imageを持っている。１：N　の1側にあたるモデルにhas_manyを記載する必要がある
  has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :profile_image
  #profile_imageという名前でActiveStorageでプロフィール画像を保存できるように設定

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample_author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
    end
    profile_image.variant(resize_to_limit: [100, 100]).processed
  end

end

class PostImage < ApplicationRecord
  has_one_attached :image
  #ユーザーに属する。１：NのN側に記載する必要がある　PostImageモデルに関連付けられるのは１つのUserモデルのため　単数形のuserになっている
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :shop_name, presence: true

  #imageが存在しているかを確認するバリデーション
  validates :image, presence: true
  #get_imageメソッドはアクションとは少し違い、特定の処理を名前で呼び出すことができるようになる。
  #PostImgaeモデルの中に記述することで、カラムを呼び出すようにこの処理（メソッド）を呼び出すことができる。

  #下記のメソッドは画像が設定されない場合はapp/assets/imagesに格納されているno_image.jpgをデフォルト画像としてActiveStorageに格納し、その画像を表示するというもの
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image
  end

  #favorited_by?メソッドは引数で渡されたユーザーidがFavoritesテーブル内に存在(Exists?)するかどうかを調べる
  def favorited_by?(user)
    favorites.exists?(user_id: user_id)
  end

end

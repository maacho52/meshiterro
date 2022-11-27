class PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    #if式を用いて対象のカラム(image,shopname)にデータが保存された場合はsaveメソッドがtrueになりリダイレクトされる。
    #バリデーションにより保存できなかった場合、saveメソッドがfalseになりrenderによりpost_images/new.html.erbが表示され投稿ページ
    if @post_image.save
     redirect_to post_images_path
    else
     render :new
    end 

  end

  def index
    @post_images = PostImage.page(params[:page])
    #1ページ分の決められた数のデータだけを、新しい順に取得するように変更する
    #pageメソッドはkaminariをインストールしたことで使用可能になった
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.delete
    redirect_to post_images_path
  end

  private

  def post_image_params
    params.require(:post_image).permit(:shop_name, :image, :caption)
  end

end

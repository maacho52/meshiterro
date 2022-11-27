class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]


  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.page(params[:page])
    #特定のユーザ（@user）に関連付けられた投稿全て（.post_images）を取得し
    #@post_imagesに渡す という処理を行う →変更後→　1ページ分の決められた数のデータだけ新しい順に取得。
  end


  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end


  private


  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def is_matching_login_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to post_images_path
    end
  end

end

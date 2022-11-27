class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top]
  #↑ログイン認証が済んでいない状態でトップページ以外の画面にアクセスしてもログイン画面へリダイレクトするようになる
  #authenticate_userはdevise側が用意しているメソッド。:authenticate_user!とすることでログインが認証されていなけらば、ログイン画面へリダイレクトする
  before_action :configure_permitted_parameters, if: :devise_controller?

    #after_sign_in_path_forはDeviseが用意しているメソッドでサインイン後にどこに遷移するかを設定している
    def after_sign_in_path_for(resource)
      post_images_path
    end

    #Deviseが用意しているメソッド。サインアウト後の遷移先の指定
    def after_sign_out_path_for(resource)
      about_path
    end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end

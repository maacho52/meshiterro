Rails.application.routes.draw do

  devise_for :users
  root to: "homes#top"
  #resources でルーティングの自動生成、onlyオプションで生成するルーティングの限定ができる
  resources :post_images, only: [:new, :create, :index, :show, :destroy] do
    resource :favorites, only: [:create, :destroy]
    #resourceが単数形になっている↑　単数形にするとURLに/:idが含まれなくなる
    #いいねしたユーザー自身のidが分からなくても関連するほかのモデルからidを特定できる　場合に用いることが多い。
    resources :post_comments, only: [:create, :destroy]
  end  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'homes/about' => 'homes#about', as: 'about'
  resources :users, only: [:show, :edit, :update]
end

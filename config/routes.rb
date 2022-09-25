Rails.application.routes.draw do
root to: 'public/homes#top'
get '/top' => 'public/homes#top', as:'top'
get '/about' => 'public/homes#about', as:'about'

  # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

scope module: :public do
  resources :address, only: [:edit, :index, :create, :update, :destroy]
  resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create]
  resources :customers, only: [:confirmation, :edit, :show, :withdrawal, :update]
  resources :items, only: [:index, :show]
  resources :orders, only: [:confirm, :finish, :index, :new, :show, :create]
end

namespace :admin do
    resources :customers, only: [:edit, :index, :show, :update]
    resources :genres, only: [:edit, :index, :create, :update]
    resources :items, only: [:edit, :index, :new, :show, :create, :update]
    resources :order_details, only: [:update]
    resources :orders, only: [:show, :update]
    get '/top' => 'homes#top', as:'top'
    root to: 'homes#top'
  end

end

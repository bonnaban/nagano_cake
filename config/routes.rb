Rails.application.routes.draw do
root to: 'public/homes#top'

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
  get '/top' => 'homes#top', as:'top'
  get '/about' => 'homes#about', as:'about'
  #↑asはpath名を編集している
  resources :address, only: [:edit, :index, :create, :update, :destroy]
  resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create]
  delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
  #customers
  get '/customers/my_page' => 'customers#show'
  get '/customers/information/edit' => 'customers#edit'
  patch '/customers/information' => 'customers#update'
  get '/customers/confirmation' => 'customers#confirmation'
  patch '/customers/withdrawal' => 'customers#withdrawal'
  resources :items, only: [:index, :show]
  resources :orders, only: [:index, :new, :show, :create]
  post '/orders/confirm' => 'orders#confirm'
  get '/orders/finish' => 'orders#finish'
end

namespace :admin do
    root to: 'homes#top'
    get '/top' => 'homes#top', as:'top'
    resources :customers, only: [:edit, :index, :show, :update]
    resources :genres, only: [:edit, :index, :create, :update]
    resources :items, only: [:edit, :index, :new, :show, :create, :update]
    resources :order_details, only: [:update]
    resources :orders, only: [:show, :update]
  end

end

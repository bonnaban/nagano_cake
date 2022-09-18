Rails.application.routes.draw do
get "search" => "searches#search"
get '/about' => 'homes#about', as:'about'

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

namespace :admin do
    resources :customers, :genres, :items, :order_details, :orders
    get '/' => 'homes#top', as:'top'
  end
  
end

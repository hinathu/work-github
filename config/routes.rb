Rails.application.routes.draw do


# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

# 管理者側のルーティング設定
  namespace :admin do
    # get 'order/show'
    resources :order, only: [:show, :update]

    resources :order_details, only: [:update]

    # get 'customers' => 'customers#index'
    # get 'customers/show'
    # get 'customers/edit'
    resources :customers, only: [:index, :show, :edit, :update]

    # get 'genres' => 'genres#index'
    # get 'genres/edit'
    resources :genres, only: [:index, :create, :edit, :update]

    # get 'items' => 'items#index'
    # get 'items/new' => 'items#new'
    # get 'items/show'
    # get 'items/edit'
    resources :items, only: [:new, :create, :index, :show, :edit, :update]

    get '/' => 'homes#top'
  end

  # 会員側のルーティング設定
  scope module: :public do

    # get 'orders/new'
    post 'orders/comfirm' => 'orders#comfirm', as: 'comfirm'
    get 'orders/complete' => 'orders#complete', as: 'complete'
    # get 'orders' => 'orders#index'
    # get 'orders/show'
    resources :orders, only: [:new, :create, :index, :show]

    # get 'addresses' => 'addresses#index'
    # get 'addresses/edit'
    resources :addresses, only: [:index, :create ,:edit, :update, :destroy]

    # get 'cart_items' => 'cart_items#index'
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all_cart_items'
    resources :cart_items, only: [:index, :create, :update, :destroy]

    get 'customers/my_page' => 'customers#show', as: 'customer'
    get 'customers/information/edit' => 'customers#edit', as: 'edit'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
    patch 'customers/:id' => 'customers#update', as: 'update_customer'

    # get 'items' => 'items#index'
    # get 'items/show'
    resources :items, only: [:index, :show]

    root to: "homes#top", as: "top"
    get 'about' => 'homes#about', as: "about"
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  
  get 'settings/index'

  get 'settings/update'

  get 'view_orders/index'

  get '/en/home_index_path' => 'home#index'

  get '/en/cart_path' => 'carts#show'

  get '/en/product/category/:id', to: 'products#category', as: 'category'

  get '/en/carts/:id/cupon_path', to: 'carts#cupon_apply', as: 'cupon'

  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  scope '(:locale)' do
    resources :settings, only: %i(index create destroy)
    resource :settings, only: [:edit] do
      collection do
        patch 'update_password'
      end
    end
    resources :home, only: %i(index create)
    resources :books, only: %i(show update)
    resources :orders, only: %i(index create)
    resources :line_items, only: %i(index new create update destroy)
    resources :carts, only: %i(show edit)
    resources :payment, only: %i(index create)
    resources :confirm, only: [:index]
    resources :complete, only: [:index]
    resources :delivery, only: %i(index create)
    resources :view_orders, only: [:index]
    resource :product do
      resources :comments
    end

    root 'home#index', as: 'store', via: :all
  end
end

Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      jsonapi_resources :brands, only: [:index, :show]
      jsonapi_resources :listings, only: [:index, :show]
      jsonapi_resources :product_lines, only: [:index, :show]
      jsonapi_resources :products, only: [:index, :show]

      post :login, to: 'sessions#create', as: :login
      delete :logout, to: 'sessions#destroy', as: :logout
      resources :users, only: [:create], as: :signup

      namespace :admin do
        jsonapi_resources :brands, only: [:create, :update, :delete]
        jsonapi_resources :listings, only: [:create, :update, :delete]
        jsonapi_resources :product_lines, only: [:create, :update, :delete]
        jsonapi_resources :products, only: [:create, :update, :delete]
        jsonapi_resources :users, only: [:index, :show, :update, :destroy]
      end
    end
  end
end

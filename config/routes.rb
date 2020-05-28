Rails.application.routes.draw do
  namespace :api do
    namespace :admin do
      resources :authorizations, only: [:create]
      jsonapi_resources :brands, only: [:create, :update, :delete]
      jsonapi_resources :product_lines, only: [:create, :update, :delete]
      jsonapi_resources :products, only: [:create, :update, :delete]
      jsonapi_resources :listings, only: [:create, :update, :delete]
    end

    namespace :v1 do
      jsonapi_resources :brands, only: [:index, :show]
      jsonapi_resources :product_lines, only: [:index, :show]
      jsonapi_resources :products, only: [:index, :show]
      jsonapi_resources :listings, only: [:index, :show]
    end
  end
end

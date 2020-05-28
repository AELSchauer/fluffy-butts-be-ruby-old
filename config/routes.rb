Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      jsonapi_resources :brands, only: [:index, :show]
      jsonapi_resources :product_lines, only: [:index, :show]
      jsonapi_resources :products, only: [:index, :show]
      jsonapi_resources :listings, only: [:index, :show]
    end
  end
end

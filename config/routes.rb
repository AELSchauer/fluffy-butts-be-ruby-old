Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :brands, only: [:index, :show] do
        resources :product_lines, only: :index
      end

      resources :product_lines, only: [:index, :show]
      resources :products, only: [:index, :show]
    end
  end
end

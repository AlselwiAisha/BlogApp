Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'users/confirmations'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root "users#index"
  resources :users , only: [:index, :show]do
    resources :posts do
      resources :comments
      resources :likes, only: [:create]
    end
  end
  namespace :api, defaults: { format: 'json' } do
      resources :users, only: [] do
        resources :posts, only: [:index] do
          resources :comments, only: [:index, :create]
        end
      end
  end
end

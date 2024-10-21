Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  get 'up', to: 'rails/health#show', as: :rails_health_check
  root 'info#index'

  namespace :v1 do
    resources :uploads, param: :signed_id, only: %i[create show]
    resources :sessions, only: %i[create] do
      post :refresh
    end
    get 'users/me', to: 'users#me'
  end
end

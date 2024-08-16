Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  # active_storage override routes for authention required
  get  '/rails/active_storage/disk/:encoded_key/*filename', to: 'disk#show'
  put  '/rails/active_storage/disk/:encoded_token', to: 'disk#update'
  post '/rails/active_storage/direct_uploads', to: 'direct_uploads#create'

  get 'up', to: 'rails/health#show', as: :rails_health_check
  root 'info#index'

  namespace :api do
    namespace :v1 do
      resources :uploads, param: :signed_id,
                          only: %i[create show]
    end
  end
end

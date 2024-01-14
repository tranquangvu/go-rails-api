Rails.application.routes.draw do
  if ENV.fetch('APP_DOCUMENT') == 'true'
    mount Rswag::Ui::Engine => '/docs'
    mount Rswag::Api::Engine => '/docs'
  end
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
      namespace :auth do
        devise_scope :user do
          post :sign_up, to: 'registrations#create'
          post :sign_in, to: 'sessions#create'
          delete :sign_out, to: 'sessions#destroy'
          resource :confirmation, only: %i[create update]
          resource :password, only: %i[create update]
        end
        devise_for :users, singular: :user, skip: :all

        resource :profile, only: %i[show] do
          member do
            put :general
            put :password
            put :email
          end
        end
      end
    end
  end
end

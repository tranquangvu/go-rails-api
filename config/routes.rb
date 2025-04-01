Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  if ENV['APP_DOCUMENT'].present?
    mount Rswag::Ui::Engine => '/docs'
    mount Rswag::Api::Engine => '/docs'
  end

  get 'up', to: 'rails/health#show', as: :rails_health_check

  # active storage routes
  get 'files/:signed_id' => 'active_storage/blobs/redirect#show', as: :file
  # TODO: Fix this to be able to get uploaded file
  # if Rails.application.config.active_storage.service.in?(%i[local test])
  #   get 'disk/:encoded_key/*filename' => 'active_storage/disk#show', as: :rails_disk_service
  # end

  root 'home#index'
  namespace :api do
    namespace :v1 do
      namespace :auth do
        devise_scope :user do
          post :sign_up, to: 'registrations#create'
          post :sign_in, to: 'sessions#create'
          delete :sign_out, to: 'sessions#destroy'
          resource :confirmation, only: %i[create update]
          resource :password, only: %i[create update]
        end
        devise_for :users, singular: :user, skip: :all
        resource :profile, only: %i[show update]
      end
      resources :uploads, param: :signed_id, only: %i[create show]
    end
  end
end

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  if ENV['APP_DOCUMENT'].present?
    mount Rswag::Ui::Engine => '/docs'
    mount Rswag::Api::Engine => '/docs'
  end

  get 'up', to: 'rails/health#show', as: :rails_health_check

  get 'blobs/:signed_id' => 'active_storage/blobs/redirect#show', as: :blob
  if Rails.application.config.active_storage.service.in?(%i[local test])
    get 'disk/:encoded_key/*filename' => 'active_storage/disk#show', as: :rails_disk_service
  end

  root 'home#index'
  namespace :api do
    namespace :v1 do
      namespace :auth do
        resource :profile, only: %i[show update]
      end
      resources :blobs, param: :signed_id, only: %i[create show]
    end
  end
end

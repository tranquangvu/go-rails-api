require 'sidekiq/web'
require 'sidekiq/cron/web'

Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: '_interslice_session'
if ENV['SIDEKIQ_WEB_USERNAME'].present? && ENV['SIDEKIQ_WEB_PASSWORD'].present?
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_WEB_USERNAME'])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_WEB_PASSWORD']))
  end
end

Rails.application.routes.draw do
  if ENV['API_DOCS'] == 'true'
    mount Rswag::Ui::Engine => '/api-docs'
    mount Rswag::Api::Engine => '/api-docs'
  end
  mount Sidekiq::Web => '/sidekiq'

  # active_storage override routes for authention required
  get  '/rails/active_storage/disk/:encoded_key/*filename', to: 'disk#show'
  put  '/rails/active_storage/disk/:encoded_token', to: 'disk#update'
  post '/rails/active_storage/direct_uploads', to: 'direct_uploads#create'

  root 'info#index'
  get 'up', to: 'rails/health#show', as: :rails_health_check

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

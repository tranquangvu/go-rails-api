source 'https://rubygems.org'

ruby '3.3.4'

gem 'rails', '~> 7.2.0'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'tzinfo-data', platforms: %i[windows jruby]
gem 'bootsnap', require: false
gem 'active_storage_validations'
gem 'image_processing', '~> 1.2'
gem 'ruby-vips'
gem 'aws-sdk-s3', require: false
gem 'rack-cors'
gem 'blueprinter'
gem 'seedbank'
gem 'pundit'
gem 'pagy'
gem 'slim'
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'lograge'
gem 'sentry-ruby'
gem 'sentry-rails'

group :development, :test do
  gem 'pry'
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'
  gem 'brakeman', require: false
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  gem 'rubocop', require: false
  gem 'letter_opener'
  gem 'annotate'
  gem 'bullet'
end

group :test do
  gem 'rspec-rails', '~> 6.0', '>= 6.0.3'
  gem 'simplecov', require: false
  gem 'shoulda-matchers'
  gem 'pundit-matchers'
end

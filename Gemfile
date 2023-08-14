source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'rails', '~> 7.0.8'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'bootsnap', require: false
gem 'active_storage_validations'
gem 'image_processing', '>= 1.2'
gem 'ruby-vips'
gem 'aws-sdk-s3', require: false
gem 'rack-cors'
gem 'blueprinter'
gem 'seedbank'
gem 'pundit'
gem 'pagy'
gem 'slim'
gem 'devise'
gem 'devise-jwt'
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'sentry-ruby'
gem 'sentry-rails'
gem 'rswag'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  gem 'rubocop', require: false
  gem 'brakeman', require: false
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

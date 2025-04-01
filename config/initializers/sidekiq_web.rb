require 'sidekiq/web'
require 'sidekiq/cron/web'

if (sidekiq_web_username = ENV['SIDEKIQ_WEB_USERNAME']).present? && (sidekiq_web_password = ENV['SIDEKIQ_WEB_PASSWORD']).present?
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(Digest::SHA256.hexdigest(username), Digest::SHA256.hexdigest(sidekiq_web_username)) &
      ActiveSupport::SecurityUtils.secure_compare(Digest::SHA256.hexdigest(password), Digest::SHA256.hexdigest(sidekiq_web_password))
  end
end

if ENV['SENTRY_DNS'].present?
  Sentry.init do |config|
    config.dsn = ENV['SENTRY_DNS']
    config.breadcrumbs_logger = [:active_support_logger, :http_logger]

    # To activate performance monitoring, set one of these options.
    # We recommend adjusting the value in production:
    config.traces_sample_rate = 1.0
    # or
    config.traces_sampler = lambda do |context|
      true
    end
  end
end

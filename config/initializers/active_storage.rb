ActiveStorage::Engine.configure do
  config.active_storage.content_types_to_serve_as_binary.delete('image/svg+xml')
  config.active_storage.service_urls_expire_in = 1.hour

  # Disable track_variants
  config.active_storage.track_variants = false

  # For safety, we should not use default active storage routes
  config.active_storage.draw_routes = false
end

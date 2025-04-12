# Fix issue: ActionDispatch::Routing::RouteSet#add_route': Invalid route name, already in use: 'rails_disk_service'
# Ref: https://github.com/rails/rails/blob/fb0e36c7cc873911462f6fad675842b87fb948a8/activestorage/lib/active_storage.rb#L363C19-L363C30
ActiveStorage.draw_routes = false

ActiveStorage::Engine.configure do
  config.active_storage.content_types_to_serve_as_binary.delete('image/svg+xml')
  config.active_storage.service_urls_expire_in = 1.hour
  # Disable variant tracking features
  config.active_storage.track_variants = false
  # For safety, we don't use default active storage routes
  config.active_storage.draw_routes = false
end

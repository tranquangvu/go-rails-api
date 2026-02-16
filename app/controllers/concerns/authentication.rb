module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate
  end

  private

  def authenticate
    payload = authenticate_with_http_token do |token, _|
      JWT::Decoder.new.call(token:)
    rescue JWT::DecodeError
      nil
    end
    raise APIError::NotAuthenticatedError unless payload

    Current.user_id = payload[:sub]
    Current.session_id = payload[:sid]
    Current.user_roles = %i[user]
  end

  def set_refresh_token(value:, expires:)
    cookies[:refresh_token] = { value:, expires:, secure: true,
                                httponly: true, same_site: :lax, path: '/api/v1/auth/refresh' }
  end
end

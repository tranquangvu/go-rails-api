module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end

  private

  def require_authentication
    payload, = JWTAuth::TokenDecoder.new.call(cookies.signed[:access_token])
    raise APIError::BadRequestError, 'Invalid token' if payload.blank? || payload['sid'].blank? || payload['sub'].blank?

    Current.session = Session.find_by(id: payload['sid'], user_id: payload['sub'])
    raise APIError::NotAuthenticatedError unless Current.session
  end

  def find_session_by_cookie
    Session.find_by(id: cookies.signed[:session_id])
  end

  def set_auth_cookies(access_token:, refresh_token:)
    cookies.signed[:access_token] = { value: access_token, httponly: true, same_site: :lax }
    cookies.signed[:refresh_token] = { value: refresh_token, httponly: true, same_site: :lax }
  end

  def terminate_session
    Current.session.destroy
    cookies.delete(:access_token)
    cookies.delete(:refresh_token)
  end
end

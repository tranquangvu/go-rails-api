module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate
  end

  private

  def authenticate
    token = extract_bearer_token
    raise APIError::NotAuthenticatedError.new unless token

    decoded = decode_token(token)
    raise APIError::NotAuthenticatedError.new unless decoded

    payload = decoded.first
    user = find_user(payload['sub'])
    raise APIError::NotAuthenticatedError.new unless user

    session = find_session(payload['sid'])
    raise APIError::NotAuthenticatedError.new unless session
    raise APIError::NotAuthenticatedError.new unless session.user_id == user.id
    raise APIError::NotAuthenticatedError.new if session.expired_at && session.expired_at < Time.current

    Current.user_id = user.id
    Current.session_id = session.id
  end

  def extract_bearer_token
    authorization_header = request.headers['Authorization']
    return nil unless authorization_header

    match = authorization_header.match(/^Bearer (.+)$/)
    match&.captures&.first
  end

  def decode_token(token)
    jwt_decoder.call(token)
  end

  def find_user(user_id)
    User.find_by(id: user_id)
  end

  def find_session(session_id)
    Session.find_by(id: session_id)
  end

  def jwt_decoder
    @jwt_decoder ||= JWT::Decoder.new
  end
end

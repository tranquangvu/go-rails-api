module Auths
  class RefreshToken
    include Dry::Monads[:result]

    def initialize(jwt_encoder = JWT::Encoder.new)
      @jwt_encoder = jwt_encoder
    end

    def call(refresh_token:)
      return Failure(APIError::NotAuthenticatedError.new('Missing refresh token')) if refresh_token.blank?

      token_hash = Digest::SHA256.hexdigest(refresh_token)
      session = Session.find_by(token_hash:)
      return Failure(APIError::NotAuthenticatedError.new('Invalid refresh token')) unless session

      return Failure(APIError::NotAuthenticatedError.new('Session expired')) if session.expired_at < Time.current

      user = session.user
      return Failure(APIError::NotAuthenticatedError.new('User not found')) unless user

      access_token = jwt_encoder.call({ sub: user.id, sid: session.id }, exp: 15.minutes.from_now)

      Success({ user:, session:, access_token: })
    end

    private

    attr_reader :jwt_encoder
  end
end

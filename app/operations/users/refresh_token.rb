module Auths
  class RefreshToken
    include Dry::Monads[:result]

    def initialize(jwt_encoder = JWT::Encoder.new)
      @jwt_encoder = jwt_encoder
    end

    def call(token:)
      session, user = find_session(token)
      return Failure(APIError::NotAuthenticatedError.new('Invalid refresh token')) unless session && user

      session = update_session(session)
      access_token = jwt_encoder.call({ sub: user.id, sid: session.id }, expired_at: 15.minutes.from_now)
      refresh_token = session.token

      Success({ user:, session:, access_token:, refresh_token: })
    end

    private

    attr_reader :jwt_encoder

    def find_session(token)
      return unless token.present?

      hash = Digest::SHA256.hexdigest(token)
      session = Session.active.find_by(token_hash: hash)
      [session, session&.user]
    end

    def update_session(session)
      session.update(
        token: SecureRandom.hex(32),
        expired_at: 7.days.from_now
      )
    end
  end
end

module Auths
  class Login
    include Dry::Monads[:result]

    def initialize(token_encoder = JWTAuth::TokenEncoder.new)
      @token_encoder = token_encoder
    end

    def call(params)
      user = User.authenticate_by(params.slice(:email, :password))
      return Failure(APIError::NotAuthenticatedError.new) unless user

      session = create_session(use)
      access_token = token_encoder.call({ sub: user.id, sid: session.id }, exp_time: 15.minutes)
      refresh_token = session.generate_token_for(:session_refresh)

      Success({ user:, access_token:, refresh_token: })
    end

    private

    attr_reader :token_encoder

    def create_session(user)
      Session.create!(
        user:,
        secret: SecureRandom.base64(24),
        user_agent: Current.user_agent,
        ip_address: Current.ip_address
      )
    end
  end
end

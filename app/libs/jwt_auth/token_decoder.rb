module JWTAuth
  class TokenDecoder
    def call(token, algorithm: 'HS256')
      options = { algorithm:, verify_jti: true, verify_iat: true }
      JWT.decode(token, ENV.fetch('JWT_SECRET'), true, **options)
    rescue JWT::DecodeError
      nil
    end
  end
end

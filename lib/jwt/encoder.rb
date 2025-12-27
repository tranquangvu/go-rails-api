module JWT
  class Encoder
    def call(payload, algorithm: 'HS256')
      extended_payload = { **payload, iat: Time.current.to_i, jti: SecureRandom.uuid }
      JWT.encode(extended_payload, ENV.fetch('JWT_SECRET'), algorithm)
    end
  end
end

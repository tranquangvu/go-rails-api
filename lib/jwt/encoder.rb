module JWT
  class Encoder
    def call(payload, expired_at: 1.hour.from_now, algorithm: 'HS256')
      extended_payload = { **payload, iat: Time.current.to_i, jti: SecureRandom.uuid, exp: expired_at.to_i }
      JWT.encode(extended_payload, ENV.fetch('JWT_SECRET'), algorithm)
    end
  end
end

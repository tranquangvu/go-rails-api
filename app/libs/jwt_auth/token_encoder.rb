module JWTAuth
  class TokenEncoder
    def call(payload, algorithm: 'HS256', exp_time: 15.minutes)
      encoded_payload = merge_payload(payload, exp_time:)
      JWT.encode(encoded_payload, ENV.fetch('JWT_SECRET'), algorithm)
    end

    private

    def merge_payload(payload, exp_time:)
      now = Time.current.to_i
      payload.clone.tap do |h|
        h['iat'] ||= now
        h['exp'] ||= now + exp_time.to_i
        h['jti'] ||= SecureRandom.uuid
      end
    end
  end
end

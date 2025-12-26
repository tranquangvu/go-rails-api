module JWT
  class Encoder
    def call(payload, algorithm: 'HS256')
      encoded_payload = extend_payload(payload)
      JWT.encode(encoded_payload, ENV.fetch('JWT_SECRET'), algorithm)
    end

    private

    def extend_payload(payload)
      now = Time.current.to_i
      payload.clone.tap do |h|
        h['iat'] ||= now
        h['exp'] ||= now + exp.to_i
        h['jti'] ||= SecureRandom.uuid
      end
    end
  end
end

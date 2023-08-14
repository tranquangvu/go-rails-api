module APIError
  class StandardError < ::StandardError
    attr_reader :message, :errors, :status, :code

    def initialize(message: nil, errors: [], status: nil, code: nil) # rubocop:disable Lint/MissingSuper
      @message = message
      @errors = errors
      @status = status
      @code = code
    end

    def to_hash
      {
        message: message,
        errors: errors,
        status: status,
        code: code
      }
    end

    def serializable_hash
      to_hash.compact_blank
    end

    def to_json(_options = {})
      serializable_hash.to_json
    end
  end
end

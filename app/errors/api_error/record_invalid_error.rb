module APIError
  class RecordInvalidError < StandardError
    def initialize(errors = [])
      super(
        message: 'Unprocessable entity',
        errors: errors,
        status: 422
      )
    end

    def serializable_hash
      {
        message: message,
        status: status,
        errors: serializable_errors(errors)
      }
    end

    private

    def serializable_errors(errors)
      errors.reduce([]) do |memo, error|
        memo << {
          field: error.attribute,
          message: error.full_message
        }
      end
    end
  end
end

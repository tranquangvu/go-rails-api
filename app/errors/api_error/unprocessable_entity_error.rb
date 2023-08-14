module APIError
  class UnprocessableEntityError < StandardError
    def initialize(message: nil, errors: [])
      super(
        message: message || 'Unprocessable entity',
        errors: errors,
        status: 422
      )
    end
  end
end

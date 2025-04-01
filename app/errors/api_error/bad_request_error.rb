module APIError
  class BadRequestError < StandardError
    def initialize(message: nil, errors: [])
      super(
        message: message || 'The request can not be processed',
        errors: errors,
        status: 400
      )
    end
  end
end

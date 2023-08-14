module APIError
  class BadRequestError < StandardError
    def initialize(message = nil)
      super(
        message: message || 'The request can not be processed',
        status: 400
      )
    end
  end
end

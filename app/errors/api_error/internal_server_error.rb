module APIError
  class InternalServerError < StandardError
    def initialize(message = nil)
      super(
        message: message || 'Something went wrong',
        status: 500
      )
    end
  end
end

module APIError
  class NotAuthenticatedError < StandardError
    def initialize(message = nil)
      super(
        message: message || 'You are not authenticated',
        status: 401
      )
    end
  end
end

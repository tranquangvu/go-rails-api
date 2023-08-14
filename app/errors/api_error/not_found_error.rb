module APIError
  class NotFoundError < StandardError
    def initialize(message = nil)
      super(
        message: message || 'The finding resource can not be found',
        status: 404
      )
    end
  end
end

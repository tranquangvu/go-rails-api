module APIError
  class ParamMissingError < StandardError
    def initialize(param = nil)
      super(
        message: "Param '#{param}' is missing or the value is empty",
        status: 400
      )
    end
  end
end

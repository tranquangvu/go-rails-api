module Auth
  class UpdatePassword
    include Dry::Monads[:result]

    def call(current_password, new_password)
    end
  end
end

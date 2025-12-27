module API
  module V1
    module Auth
      class RegistrationsController < BaseController
        skip_before_action :authenticate, only: :create

        def create
          result = Auths::Register.call(email: params[:email], password: params[:password])
          case result
          when Success
            render json: result.value!, status: :created
          when Failure
            render_api_error(result.failure, status: :unprocessable_entity)
          end
        end
      end
    end
  end
end

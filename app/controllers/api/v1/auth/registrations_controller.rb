module API
  module V1
    module Auth
      class RegistrationsController < BaseController
        skip_before_action :authenticate, only: :create

        def create
          result = Auth::RegisterUser.call(**register_params)
          case result
          when Success
            render json: result.value!, status: :created
          when Failure
            render_api_error(result.failure, status: :unprocessable_entity)
          end
        end

        private

        def register_params
          params.expect(:name, :email, :password)
        end
      end
    end
  end
end

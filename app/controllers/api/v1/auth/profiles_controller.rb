module API
  module V1
    module Auth
      class ProfilesController < BaseController
        def show
          render_resource(Current.user)
        end

        def update
          result = Auths::UpdateProfile.call(profile_params)
          case result
          when Success
            render_resource(result.value!)
          when Failure
            render_api_error(result.failure, status: :unprocessable_entity)
          end
        end

        private

        def profile_params
          params.expect(:name, :avatar, :password_challenge)
        end
      end
    end
  end
end

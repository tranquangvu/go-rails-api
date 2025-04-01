module API
  module V1
    module Auth
      class ProfilesController < BaseController
        def show
          render_resource(current_user)
        end

        def update
          user = User.find(current_user.id)
          if user.update_with_password(user_params)
            render_resource(user)
          else
            render_resource_errors(user.errors)
          end
        end

        private

        def user_params
          params.require(:user).permit(:email, :first_name, :last_name, :avatar, :password, :current_password)
        end
      end
    end
  end
end

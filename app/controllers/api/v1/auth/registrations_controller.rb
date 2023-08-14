module API
  module V1
    module Auth
      class RegistrationsController < Devise::RegistrationsController
        respond_to :json

        private

        def sign_up_params
          params.require(:user).permit(:email, :first_name, :last_name, :password)
        end

        def respond_with(resource, _opts = {})
          return render_resource_errors(resource.errors) if resource.errors.any?

          case action_name
          when 'create', 'update'
            render_resource(resource, status: resource.previous_changes[:id].present? ? :created : :ok)
          when 'destroy'
            head(:no_content)
          end
        end
      end
    end
  end
end

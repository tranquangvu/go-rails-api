module API
  module V1
    module Auth
      class PasswordsController < Devise::PasswordsController
        respond_to :json

        def create
          self.resource = resource_class.send_reset_password_instructions(resource_params)
          render json: { message: I18n.t('devise.passwords.send_paranoid_instructions') }
        end

        def update
          self.resource = resource_class.reset_password_by_token(resource_params)

          if resource.errors.empty?
            resource.unlock_access! if unlockable?(resource)
            render json: { message: I18n.t('devise.passwords.updated_not_active') }
          else
            render_resource_errors(resource.errors)
          end
        end
      end
    end
  end
end

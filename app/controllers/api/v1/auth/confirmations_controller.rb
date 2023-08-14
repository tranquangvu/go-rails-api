module API
  module V1
    module Auth
      class ConfirmationsController < Devise::ConfirmationsController
        respond_to :json

        def create
          self.resource = resource_class.send_confirmation_instructions(resource_params)
          render json: { message: I18n.t('devise.confirmations.send_paranoid_instructions') }
        end

        def update
          self.resource = resource_class.confirm_by_token(resource_params[:confirmation_token])

          if resource.errors.empty?
            render json: { message: I18n.t('devise.confirmations.confirmed') }
          else
            render_resource_errors(resource.errors)
          end
        end
      end
    end
  end
end

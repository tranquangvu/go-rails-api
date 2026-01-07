module API
  module V1
    module Auth
      class AccountsController < BaseController
        def show
          render_resource(Current.user)
        end

        def update
          # TODO: Implement account update
        end
      end
    end
  end
end

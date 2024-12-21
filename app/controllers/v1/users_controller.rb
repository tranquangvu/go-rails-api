module V1
  class UsersController < BaseController
    def me
      render_resource(Current.user)
    end
  end
end

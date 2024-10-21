module V1
  class UsersController < BaseController
    def me
      user = Current.user
      render_resource(user)
    end
  end
end

module API
  module V1
    class BaseController < ApplicationController
      before_action :authenticate_user!
    end
  end
end

# Fix sign_in_count increase on every request
# https://github.com/waiting-for-dev/devise-jwt/issues/12

module Warden
  module JWTAuth
    module OverridedStrategy
      def authenticate!
        super
        env['devise.skip_trackable'.freeze] = true if valid?
      end
    end
  end
end

Warden::JWTAuth::Strategy.prepend Warden::JWTAuth::OverridedStrategy

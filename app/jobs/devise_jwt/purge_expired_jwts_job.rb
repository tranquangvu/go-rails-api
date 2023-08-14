module DeviseJwt
  class PurgeExpiredJwtsJob < ApplicationJob
    queue_as :low

    def perform(check_time = Time.current)
      AllowlistedJwt.where(exp: ..check_time).destroy_all
    end
  end
end

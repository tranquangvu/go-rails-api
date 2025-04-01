# Sample usage following dependency injection principles:
#
# class ApproveUserService < ApplicationService
#   def initialize(notify_service = NotifyService.new)
#     @notify_service = notify_service
#   end
#
#   def call(params)
#     # ...
#     notify_service.call(params[:user_id], 'approved')
#     # ...
#   end
#
#   private
#
#   attr_reader :notify_service
# end

class ApplicationService
  def self.call(...)
    new.call(...)
  end

  def call
    raise NotImplementedError, "You must define `call` as instance method in #{self.class.name} class"
  end
end

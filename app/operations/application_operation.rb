# Sample usage following dependency injection principles:
#
# class Users::Approve < ApplicationOperation
#   def initialize(send_notification = Notifications::Send.new)
#     @send_notification = send_notification
#   end
#
#   def call(params)
#     # ...
#     send_notification.call(params[:user_id], 'approved')
#     # ...
#   end
#
#   private
#
#   attr_reader :notify
# end

class ApplicationOperation
  def self.call(...)
    new.call(...)
  end

  def call
    raise NotImplementedError, "You must define `call` as instance method in #{self.class.name} class"
  end
end

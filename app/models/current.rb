class Current < ActiveSupport::CurrentAttributes
  attribute :user, :user_id,
            :session, :session_id,
            :user_agent, :ip_address

  def user
    @attributes[:user] ||= User.find_by(id: user_id)
  end

  def session
    @attributes[:session] ||= Session.find_by(id: session_id)
  end
end

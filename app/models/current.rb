class Current < ActiveSupport::CurrentAttributes
  attribute :user_agent, :ip_address,
            :session_id, :user_id, :user_roles,
            :session, :user

  def user
    @attributes[:user] ||= User.find_by(id: user_id)
  end

  def session
    @attributes[:session] ||= Session.find_by(id: session_id)
  end
end

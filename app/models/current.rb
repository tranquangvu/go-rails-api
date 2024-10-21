class Current < ActiveSupport::CurrentAttributes
  attribute :user_id, :session_id
  attribute :user_agent, :ip_address
end

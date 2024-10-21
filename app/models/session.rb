# == Schema Information
#
# Table name: sessions
#
#  id         :uuid             not null, primary key
#  expired_at :datetime
#  ip_address :string
#  secret     :string           not null
#  user_agent :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_sessions_on_secret   (secret) UNIQUE
#  index_sessions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
class Session < ApplicationRecord
  belongs_to :user

  generates_token_for :session_refresh, expires_in: 7.days { secret }
end

# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  verified        :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  generates_token_for :email_verification, expires_in: 2.days { email }
  generates_token_for :password_reset, expires_in: 15.minutes do
    password_salt.last(10)
  end
  normalizes :email, with: ->(value) { value.strip.downcase }

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, allow_nil: true, length: { minimum: 12 }

  # before_validation if: :email_changed?, on: :update do
  #   self.verified = false
  # end

  # after_update if: :password_digest_previously_changed? do
  #   sessions.where.not(id: Current.session).delete_all
  # end
end

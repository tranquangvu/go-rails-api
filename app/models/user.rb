class User < ApplicationRecord
  has_secure_password

  has_many :sessions, dependent: :destroy
  has_one_attached :avatar

  # validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  # validates :password, allow_nil: true, length: { minimum: 8 }
  normalizes :email, with: -> { _1.strip.downcase }

  generates_token_for :email_confirm, expires_in: 2.days  { email }
  generates_token_for :password_reset, expires_in: 1.hour { password_digest }

  before_validation if: :email_changed?, on: :update do
    self.confirmed_at = nil
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).delete_all
  end

  def confirmed?
    confirmed_at.present?
  end

  def jwt_payload
    { sub: id, sid: session.id }
  end
end

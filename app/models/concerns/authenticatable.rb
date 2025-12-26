module Authenticatable
  extend ActiveSupport::Concern

  included do
    has_secure_password
    has_many :sessions, dependent: :destroy

    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, allow_nil: true, length: { minimum: 8 }
    normalizes :email, with: -> { _1.strip.downcase }

    generates_token_for :email_verify, expires_in: 2.days  { email }

    before_validation if: :email_changed?, on: :update do
      self.verified = false
    end

    after_update if: :password_digest_previously_changed? do
      sessions.where.not(id: Current.session).delete_all
    end
  end
end

class Session < ApplicationRecord
  attr_accessor :token

  belongs_to :user

  before_save :set_token_hash, if: -> { token.present? }

  private

  def set_token_hash
    self.token_hash = Digest::SHA256.hexdigest(token)
  end
end

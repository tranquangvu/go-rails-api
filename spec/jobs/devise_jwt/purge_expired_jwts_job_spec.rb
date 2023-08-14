require 'rails_helper'

RSpec.describe DeviseJwt::PurgeExpiredJwtsJob, type: :job do
  include_examples 'enqueues_job_correctly', :low

  describe '#perform' do
    let!(:user) { create(:user) }
    let!(:expired_jwt) { user.on_jwt_dispatch(:token, { 'exp' => (Time.current - 1.hour).to_i, 'jti' => SecureRandom.hex }) }
    let!(:valid_jwt) { user.on_jwt_dispatch(:token, { 'exp' => (Time.current + 1.hour).to_i, 'jti' => SecureRandom.hex }) }

    it 'deletes expired jwts' do
      DeviseJwt::PurgeExpiredJwtsJob.perform_now
      expect(AllowlistedJwt.exists?(expired_jwt.id)).to eq(false)
      expect(AllowlistedJwt.exists?(valid_jwt.id)).to eq(true)
    end
  end
end

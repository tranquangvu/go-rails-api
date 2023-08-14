require 'rails_helper'

RSpec.describe ActiveStorage::BlobPolicy, type: :policy do
  subject { described_class.new(user, blob) }

  let(:user) { nil }
  let(:blob) { ActiveStorage::Blob.new }

  it { is_expected.to permit_actions(%i[create show]) }
end

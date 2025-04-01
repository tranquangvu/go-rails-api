describe Uploads::CreateAndUploadBlobService, type: :service do
  subject { described_class.new }

  describe '#call' do
    let(:file) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/image.png'), 'image/png') }

    it 'stores file' do
      blob = nil
      expect { blob = subject.call(file) }.to change(ActiveStorage::Blob, :count).by(1)
      expect(ActiveStorage::Blob.service.exist?(blob.key)).to be(true)
    end
  end
end

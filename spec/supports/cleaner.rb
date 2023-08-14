RSpec.configure do |config|
  config.after(:suite) do
    FileUtils.rm_rf(Dir.glob("#{Rails.root}/tmp/storage/*"))
  end
end

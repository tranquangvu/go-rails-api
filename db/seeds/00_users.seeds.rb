puts '~> Create users'
10.times do |t|
  user = FactoryBot.build(:user, password: 'password123')
  user.skip_confirmation!
  user.save!
end

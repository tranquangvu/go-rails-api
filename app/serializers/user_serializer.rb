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
class UserSerializer < ApplicationSerializer
  identifier :id

  fields :email
  #  :first_name,
  #  :last_name

  # field :is_confirmed do |user|
  #   user.confirmed?
  # end

  # field :avatar_url do |user|
  #   url_for(user.avatar)
  # end
end

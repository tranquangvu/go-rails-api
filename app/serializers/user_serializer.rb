class UserSerializer < ApplicationSerializer
  identifier :id

  fields :email,
         :first_name,
         :last_name

  field :is_confirmed do |user|
    user.confirmed?
  end

  field :avatar_url do |user|
    url_for(user.avatar)
  end
end

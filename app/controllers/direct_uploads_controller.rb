class DirectUploadsController < ActiveStorage::DirectUploadsController
  skip_forgery_protection

  before_action :authenticate_user!, only: %i[create]
end

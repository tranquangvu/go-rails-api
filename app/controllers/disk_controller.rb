class DiskController < ActiveStorage::DiskController
  before_action :authenticate_user!, only: %i[update]
end

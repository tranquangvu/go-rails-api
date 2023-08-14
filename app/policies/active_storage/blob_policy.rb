module ActiveStorage
  class BlobPolicy < ApplicationPolicy
    def create?
      true
    end

    def show?
      true
    end
  end
end

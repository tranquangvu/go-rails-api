module ActiveStorage
  class PurgeUnattachedBlobsJob < ApplicationJob
    queue_as :low

    def perform
      ActiveStorage::Blob.unattached.where(created_at: ..1.days.ago).find_each(&:purge)
    end
  end
end

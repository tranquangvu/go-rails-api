module Pagination
  extend ActiveSupport::Concern

  PAGY_KEYS_TRANSFORMER = {
    items: :page_size,
    page: :page_number,
    count: :total_count,
    prev: :prev_page,
    next: :next_page,
    last: :last_page
  }.freeze

  def paginate(collection)
    pagy(collection, page: page_number, items: page_size)
  end

  def paginate_array(array)
    pagy_array(array, page: page_number, items: page_size)
  end

  def paginate_meta(pagy)
    pagy_metadata(pagy).transform_keys { |key| PAGY_KEYS_TRANSFORMER[key] }
  end

  def page_number
    params.dig(:page, :number) || 1
  end

  def page_size
    params.dig(:page, :size) || Pagy::DEFAULT[:items]
  end
end

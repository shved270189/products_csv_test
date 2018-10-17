class ProductLoaderService
  CSV_PATH = Rails.application.secrets.products_data
  PRODUCT_COLUMN_ASSOCIATION = {
    'product_name' => 'name',
    'photo_url' => 'url',
    'price_cents' => 'price',
    'sku (unique id)' => 'sku'
  }.freeze

  def call
    @product_ids = []
    load_data
    delete_old_products
  end

  private

  def load_data
    row_number = 0
    HippieCSV.stream(CSV_PATH) do |row|
      if row_number.zero?
        define_headers!(row)
      else
        process_product_data(row)
      end
      row_number += 1
    end
  end

  def define_headers!(row)
    row.each_with_index do |name, index|
      row[index] = PRODUCT_COLUMN_ASSOCIATION[name] if PRODUCT_COLUMN_ASSOCIATION[name].present?
    end
    @headers = row.map(&:to_sym)
  end

  def process_product_data(row)
    data = transform_data(row)
    update_or_create_product!(data)
  end

  def transform_data(row)
    data = {}
    @headers.each_with_index do |header_name, index|
      data[header_name] = row[index]
    end
    data.with_indifferent_access
  end

  def update_or_create_product!(data)
    @product_ids << ProductService.update_or_create!(data).id
  end

  def delete_old_products
    ProductService.keep_only_ids(@product_ids)
  end
end

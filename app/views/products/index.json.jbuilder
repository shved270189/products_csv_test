json.page @products.current_page
json.per_page @products.limit_value
json.total_count @total_count

json.products @products,
              :id,
              :name,
              :sku,
              :url,
              :barcode,
              :price,
              :producer,
              :updated_at,
              :created_at

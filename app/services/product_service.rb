class ProductService
  class << self
    def update_or_create!(attributes)
      product = Product.find_or_initialize_by(sku: attributes[:sku])
      product.update!(attributes)
      product
    end

    def keep_only_ids(ids)
      Product.where.not(id: ids).delete_all
    end
  end
end

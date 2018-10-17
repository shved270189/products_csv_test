class ProductsController < ApplicationController
  def index
    product_scope = Product.ransack(producer_eq: params[:producer]).result(distinct: true)
    @products = product_scope
                  .page(params[:page] || 1)
                  .per(params[:per_page] || DEFAULT_PER_PAGE)
    @total_count = product_scope.count
  end
end

class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page] || 1).per(params[:per_page] || DEFAULT_PER_PAGE)
    @total_count = Product.count
  end
end

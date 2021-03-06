class ProductsController < ApplicationController
  def index
    @products = Product.valid.sorted.page(params[:page])
  end

  def show
    @product = Product.find_by_id(params[:id])
    @cart_product = @product.cart_products.new
  end
end

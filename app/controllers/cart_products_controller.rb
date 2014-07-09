# -*- coding: utf-8 -*-
class CartProductsController < ApplicationController

  before_action :sign_in_required
  before_action :current_user_required
  before_action :set_cart_and_product, only: [:update, :destroy]

  def create
    @cart = @user.cart
    @product = Product.find_by_id(params[:cart_product][:product_id])
    @cart_product = CartProduct.find_by_cart_id_and_product_id(@cart.id, @product.id)
    
    if @cart_product
      @cart_product.update(amount: @cart_product.amount + 1)
      redirect_to user_cart_url(@user), notice: "商品が追加されました" and return
    end

    @cart_product = CartProduct.new(cart_product_create_parmas)
    if @cart_product.save
      redirect_to user_cart_url(@user), notice: "商品が追加されました"
    else
      render "products/show"
    end
  end

  def update
    if @cart_product.update(cart_product_update_params)
      notice = @cart_product.amount == 0 ? "商品が削除されました" : "商品の数が更新されました"
      redirect_to user_cart_url(@user), notice: notice
    else
      render "carts/show"
    end
  end

  def destroy
    @cart_product.destroy
    redirect_to user_cart_url(@user), notice: "商品が削除されました"
  end

  private

  def cart_product_create_parmas
    params.require(:cart_product).permit(:cart_id, :product_id, :amount)
  end

  def cart_product_update_params
    params.require(:cart_product).permit(:amount)
  end

  def set_cart_and_product
    @cart_product = CartProduct.find_by_id(params[:id])
    @cart = @cart_product.cart
    @product = @cart_product.product
  end

end

# -*- coding: utf-8 -*-
class Admins::ProductsController < Admins::ApplicationController

  before_action :set_product, only: [:show, :edit, :update, :destroy]
    
  def index
    @products = Product.page(params[:page])
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admins_product_url(@product), notice: "商品を追加しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update_attributes(product_params)
      redirect_to edit_admins_product_url(@product), notice: "商品情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admins_products_url
  end

  private

  def product_params
    attributes = %I(name image price description hidden display_order)
    params.require(:product).permit(attributes)
  end

  def set_product
    @product = Product.find_by_id(params[:id])
  end
 
end

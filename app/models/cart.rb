class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_products
  has_many :products, through: :cart_products

  def total_price
    total = 0
    cart_products.find_each do |cart_product|
      unit_price = cart_product.product.price
      total += unit_price * cart_product.amount
    end
    total
  end

  def total_price_with_tax
    (total_price * 1.08).to_i
  end
end

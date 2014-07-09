class CartProduct < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product

  validates :cart_id, presence: true
  validates :product_id, presence: true
  validates_numericality_of :amount, greater_than_or_equal_to:0

  after_save :destroy_if_zero_amount

  private
  
  def destroy_if_zero_amount
    if amount == 0
      destroy
    end
  end
end

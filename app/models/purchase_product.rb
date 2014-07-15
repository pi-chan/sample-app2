class PurchaseProduct < ActiveRecord::Base
  belongs_to :purchase
  belongs_to :product

  validates :purchase_id, presence: true
  validates :product_id, presence: true
  validates_numericality_of :amount, greater_than_or_equal_to:0

end

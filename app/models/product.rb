class Product < ActiveRecord::Base
  has_paper_trail

  has_many :cart_products
  has_many :carts, through: :cart_products
  has_many :purchase_products
  
  validates :name, presence: true
  validates :image, presence: true
  validates :description, presence: true
  validates_numericality_of :price, greater_than_or_equal_to:0
  validates_numericality_of :display_order, greater_than_or_equal_to:0

  scope :sorted, -> {
    order(:display_order)
  }
  
  scope :valid, -> {
    where(hidden: false)
  } 

  mount_uploader :image, UploaderBase

  paginates_per 40

end

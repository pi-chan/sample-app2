class Product < ActiveRecord::Base
  has_paper_trail

  has_many :cart_products
  has_many :carts, through: :cart_products
  has_many :purchase_products
  
  validates :name, presence: true
  validates :description, presence: true

  default_scope { order(:display_order)}

  mount_uploader :image, UploaderBase

end

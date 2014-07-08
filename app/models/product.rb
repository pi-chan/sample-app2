class Product < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true

  default_scope { order(:display_order)}

  mount_uploader :image, UploaderBase
end

class Purchase < ActiveRecord::Base
  include MultiStepModel
  extend Enumerize

  belongs_to :user
  has_many :purchase_products, dependent: :destroy

  validates :ship_name, presence: true, :if => :step1?
  validates :ship_address, presence: true, :if => :step1?
  validates :ship_zip_code, presence: true, :if => :step1?

  enumerize :delivery_time, in: [:t_8_12, :t_12_14, :t_14_16, :t_16_18, :t_18_20, :t_20_21], default: :t_8_12
  
  def self.total_steps
    3
  end

  def delivery_date_options
    (3.weekdays_from_now.to_date..14.weekdays_from_now.to_date).to_a.select{|date| date.weekday?}    
  end

  def total_price_with_tax
    (product_price + shipping_cost + cash_on_delivery) * (100 + tax_percentage) / 100
  end

  def purchased_at
    created_at.localtime.strftime("%Y/%m/%d %H:%M")
  end
  
end

class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :user_id, null: false
      t.string :ship_name, null: false
      t.string :ship_address, null: false
      t.string :ship_zip_code, null: false, limit: 7
      t.string :delivery_time
      t.date :delivery_date
      t.integer :product_price
      t.integer :shipping_cost
      t.integer :cash_on_delivery
      t.integer :tax_percentage
      t.timestamps
    end
  end
end

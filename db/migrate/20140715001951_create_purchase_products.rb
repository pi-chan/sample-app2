class CreatePurchaseProducts < ActiveRecord::Migration
  def change
    create_table :purchase_products do |t|
      t.integer :purchase_id
      t.integer :product_id
      t.integer :amount

      t.timestamps
    end
    add_index :purchase_products, [:purchase_id, :product_id], unique: true
  end
end

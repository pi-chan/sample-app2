class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :image
      t.integer :price, default: 0
      t.text :description, null: false
      t.boolean :hidden, default: false
      t.integer :display_order, default: 0
      
      t.timestamps
    end
  end
end

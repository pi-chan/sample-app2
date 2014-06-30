class CreateDiaries < ActiveRecord::Migration
  def change
    create_table :diaries do |t|
      t.integer :user_id, null: false
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end

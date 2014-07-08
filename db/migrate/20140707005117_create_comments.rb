class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :diary_id, null: false
      t.integer :commenter_id, null: false
      t.text :body

      t.timestamps
    end
  end
end

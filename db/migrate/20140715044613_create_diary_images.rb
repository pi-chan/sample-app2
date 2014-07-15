class CreateDiaryImages < ActiveRecord::Migration
  def change
    create_table :diary_images do |t|
      t.integer :user_id
      t.string :image

      t.timestamps
    end
  end
end

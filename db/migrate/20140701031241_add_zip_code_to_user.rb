class AddZipCodeToUser < ActiveRecord::Migration
  def change
    add_column :users, :ship_zip_code, :string, default: "", limit: 7
  end
end

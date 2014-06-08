class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_column :users, :image, :string
    add_column :users, :url, :string
  end
end

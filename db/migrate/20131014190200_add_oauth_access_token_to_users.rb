class AddOauthAccessTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :oauth_access_token, :string
  end
end

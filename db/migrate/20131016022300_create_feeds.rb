class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :network_id
      t.text :message
      t.date :updated_time
      t.date :created_time
      t.integer :user_id

      t.timestamps
    end

    add_index :feeds, :user_id
  end
end

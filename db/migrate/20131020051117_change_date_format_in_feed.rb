class ChangeDateFormatInFeed < ActiveRecord::Migration
  def change
    change_column :feeds, :updated_time, :datetime
    change_column :feeds, :created_time, :datetime
  end
end

class Feed < ActiveRecord::Base
  belongs_to :user

  validates :network_id, presence: true, uniqueness: true

  include FetchFacebookGroupFeed

  def self.import_fetch_feeds
    feeds = FetchFacebookGroupFeed.fetch_feeds
    feeds.each do |f|
      Feed.create(
        message:      f['message'],
        network_id:   f['network_id'],
        updated_time: f['updated_time'],
        created_time: f['created_time'],
        user:         User.find_by_uid(f['from']['id'])
      )
    end
  end
end

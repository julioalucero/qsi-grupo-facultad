class Feed < ActiveRecord::Base
  belongs_to :user

  validates :network_id, presence: true, uniqueness: true

  delegate :name, :to => :user

  include FetchFacebookGroupFeed

  acts_as_taggable

  default_scope order('created_time DESC')

  def self.fetch_feeds
    feeds = FetchFacebookGroupFeed.fetch(last_update_time)

    unless feeds.nil?
      feeds.each do |f|
        Feed.create(
          message:      f['message'],
          network_id:   f['id'],
          updated_time: f['updated_time'],
          created_time: f['created_time'],
          user:         User.find_by_uid(f['from']['id'])
        )
      end
    end
  end

  def self.last_update_time
    Feed.exists? ? Feed.order('updated_time DESC').limit(1).first.updated_time : nil
  end
end

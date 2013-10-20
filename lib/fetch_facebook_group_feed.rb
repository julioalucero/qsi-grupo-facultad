module FetchFacebookGroupFeed

  extend self

  def fetch updated_time = nil
    current_feeds = first_feed(updated_time)

    # NOTE refactor it, crate one method for the first time
    # and other for the updates
    feeds = []
    if updated_time.nil?
      feeds = paginate_feeds(current_feeds)
    else
      feeds = current_feeds
    end

    feeds.flatten
  end

  private

  def paginate_feeds current_feed
    feeds = []

    while !current_feed.nil? and !current_feed.empty?
      feeds << current_feed
      current_feed = current_feed.next_page
    end

    feeds
  end

  def admin_user
    User.find_by_email ENV['FACEBOOK_ADMIN_EMAIL']
  end

  def graph
    Koala::Facebook::API.new(admin_user.oauth_access_token)
  end

  def first_feed updated_time
    graph.get_connections ENV['FACEBOOK_GROUP'], 'feed', batch_params(updated_time)
  end

  def batch_params updated_time
    {
      :fields => 'id,message,created_time,updated_time,from',
      :limit  => 2,
      :since  => last_update_time(updated_time)
    }
  end

  def last_update_time updated_time
    Time.parse(updated_time.to_s).to_i unless updated_time.nil?
  end
end

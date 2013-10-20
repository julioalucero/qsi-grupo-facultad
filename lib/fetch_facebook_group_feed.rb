module FetchFacebookGroupFeed

  extend self

  def fetch_feeds
    current_feed = first_feed
    feeds = paginate_feeds(current_feed)
    feeds.flatten!
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

  def first_feed
    graph.get_connections ENV['FACEBOOK_GROUP'], 'feed', batch_params
  end

  def batch_params
    {
      :fields => 'id,message,created_time,updated_time,from',
      :limit  => 2
    }
  end
end

module FetchFacebookGroupFeed

  extend self

  def fetch_feeds
    admin_user = User.find_by_email ENV['FACEBOOK_ADMIN_EMAIL']
    graph = Koala::Facebook::API.new(admin_user.oauth_access_token)
    feeds = graph.get_connections ENV['FACEBOOK_GROUP'], 'feed', batch_params
    feeds
  end

  def self.batch_params
    {
      :fields => 'id,message,created_time,updated_time,from'
    }
  end
end

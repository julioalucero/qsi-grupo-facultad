module FetchFacebookGroupFeed

  extend self

  class << self
    attr_accessor :field, :limit, :access_token, :fb_until, :__paging_token
  end

  # NOTE document this method
  def fetch updated_time = nil
    current_feeds = fetch_facebook_feeds

    feeds = current_feeds

    unless feeds.empty?
      FetchFacebookGroupFeed.field, FetchFacebookGroupFeed.limit, FetchFacebookGroupFeed.access_token, FetchFacebookGroupFeed.fb_until, FetchFacebookGroupFeed.__paging_token = feeds.next_page_params[1].values
    end

    feeds.flatten
  end

  private

  def fetch_facebook_feeds
    if first_feed?
      graph.get_connections ENV['FACEBOOK_GROUP'], 'feed', batch_params
    else
      graph.get_connections ENV['FACEBOOK_GROUP'], 'feed', module_params
    end
  end

  # TODO last_update_time is not necesary
  def batch_params
    {
      :fields => 'id,message,created_time,updated_time,from',
      :limit  => 100
    }
  end

  def module_params
    {
      :fields         => field,
      :limit          => limit,
      :access_token   => access_token,
      :until          => fb_until,
      :__paging_token => __paging_token
    }
  end

  def admin_user
    User.find_by_email ENV['FACEBOOK_ADMIN_EMAIL']
  end

  def graph
    Koala::Facebook::API.new(admin_user.oauth_access_token)
  end

  def last_update_time updated_time
    Time.parse(updated_time.to_s).to_i unless updated_time.nil?
  end

  def first_feed?
    field.nil?
  end
end

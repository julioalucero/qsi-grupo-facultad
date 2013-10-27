require 'test_helper'


describe FetchFacebookGroupFeed do


  describe '#fetch_feeds' do
    it 'return all the feeds' do
      ENV['FACEBOOK_ADMIN_EMAIL'] = 'user@example.com'

      @feeds = YAML.load_file('test/factories/facebook_feeds.yml')
      @feed_1 = @feeds['feed_1']

      FetchFacebookGroupFeed.stub(:fetch, @feeds) do

        feeds = FetchFacebookGroupFeed.fetch
        feed = feeds['feed_1']

        assert_equal feeds.count, 2

        assert_equal feed['network_id'],   @feed_1['network_id']
        assert_equal feed['message'],      @feed_1['message']
        assert_equal feed['updated_time'], @feed_1['updated_time']
        assert_equal feed['created_time'], @feed_1['created_time']
        assert_equal feed['network_id'],   @feed_1['network_id']
        assert_equal feed['from']['id'],   @feed_1['from']['id']
      end
    end
  end
end

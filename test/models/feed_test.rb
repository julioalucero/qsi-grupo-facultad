require 'test_helper'
require 'fetch_facebook_group_feed'

class FeedTest < ActiveSupport::TestCase


  test "create a feed" do
    feed = FactoryGirl.create(:feed)

    assert_equal Feed.count, 1
  end

  describe 'import_fetch_feeds' do
    describe 'when exist two feeds' do
      test 'save' do
        user = FactoryGirl.create(:user)
        ENV['FACEBOOK_ADMIN_EMAIL'] = 'user@example.com'

        facebook_feeds = YAML.load_file('test/factories/facebook_feeds.yml')
        @feed_1 = facebook_feeds['feed_1']
        @feed_2 = facebook_feeds['feed_2']
        @feeds  = [@feed_1, @feed_2]

        FetchFacebookGroupFeed.stub(:fetch, @feeds) do

          Feed.fetch_feeds

          assert_equal Feed.count, 2

          feed = Feed.first
          assert_equal feed.network_id,   @feed_1['id']
          assert_equal feed.message,      @feed_1['message']
          assert_equal feed.updated_time, Date.parse(@feed_1['updated_time'])
          assert_equal feed.created_time, Date.parse(@feed_1['created_time'])
          assert_equal feed.user.uid,     user.uid
        end
      end
    end
  end
end

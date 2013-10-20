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

        @feed_1 = {
          'network_id'   => '156966857675985_614572588582074',
          'message'      => '[fisica 2]alguien me podria mandar por favor las mediciones del tp 4 de ondas que se hicieron para cada cuerda, porque tengo algunos datos incompletos. gracias :D',
          'created_time' => "2013-10-16T02:12:07+0000",
          'updated_time' => "2013-10-16T02:12:07+0000",
          'from' => {
            'name' => 'user example',
            'id'   => user.uid
          }
        }

        @feed_2 = {
          'network_id'   => '232966857675985_614572588582345',
          'message'      => '[Sistemas]  cada cuerda, porque tengo algunos.',
          'created_time' => "2012-09-16T02:11:07+0000",
          'updated_time' => "2013-10-16T02:11:07+0000",
          'from' => {
            'name' => 'another user example',
            'id'   => '1126902032'
          }
        }

        @feeds = [@feed_1, @feed_2]

        FetchFacebookGroupFeed.stub(:fetch_feeds, @feeds) do

          Feed.import_fetch_feeds

          assert_equal Feed.count, 2

          feed = Feed.first
          assert_equal feed.network_id,   @feed_1['network_id']
          assert_equal feed.message,      @feed_1['message']
          assert_equal feed.updated_time, Date.parse(@feed_1['updated_time'])
          assert_equal feed.created_time, Date.parse(@feed_1['created_time'])
          assert_equal feed.network_id,   @feed_1['network_id']
          assert_equal feed.user.uid,     user.uid
        end
      end
    end
  end
end

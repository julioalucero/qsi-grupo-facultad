require 'test_helper'


describe FetchFacebookGroupFeed do


  describe '#fetch_feeds' do
    it 'return all the feeds' do
      ENV['FACEBOOK_ADMIN_EMAIL'] = 'user@example.com'
      @feed_1 = {
        :network_id   => '156966857675985_614572588582074',
        :message      => '[fisica 2]alguien me podria mandar por favor las mediciones del tp 4 de ondas que se hicieron para cada cuerda, porque tengo algunos datos incompletos. gracias :D',
        :created_time => "2013-10-16T02:12:07+0000",
        :updated_time => "2013-10-16T02:12:07+0000",
        :from => {
          :name => 'user example',
          :id   => '1476902024'
        }
      }

      @feed_2 = {
        :network_id   => '232966857675985_614572588582345',
        :message      => '[Sistemas]  cada cuerda, porque tengo algunos.',
        :created_time => "2012-09-16T02:11:07+0000",
        :updated_time => "2013-10-16T02:11:07+0000",
        :from => {
          :name => 'another user example',
          :id   => '1126902032'
        }
      }

      @feeds = [@feed_1, @feed_2]

      FetchFacebookGroupFeed.stub(:fetch_feeds, @feeds) do

        feeds = FetchFacebookGroupFeed.fetch_feeds
        feed = feeds.first

        assert_equal feeds.count, 2

        assert_equal feed[:network_id],   @feed_1[:network_id]
        assert_equal feed[:message],      @feed_1[:message]
        assert_equal feed[:updated_time], @feed_1[:updated_time]
        assert_equal feed[:created_time], @feed_1[:created_time]
        assert_equal feed[:network_id],   @feed_1[:network_id]
        assert_equal feed[:from][:id],    @feed_1[:from][:id]
      end
    end
  end
end

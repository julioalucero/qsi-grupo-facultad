class FeedsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @q = Feed.search(params[:q])
    @feeds = @q.result.page(params[:page])
  end

  def add_feed_tags
    tags = params['feed']['tag_list']
    feed = Feed.find params[:id]
    feed.tag_list = tags
    feed.save
  end
end

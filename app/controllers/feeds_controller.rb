class FeedsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @q = Feed.search(params[:q])

    if params[:tag]
      @feeds = Feed.tagged_with(params[:tag]).page(params[:page])
    else
      @feeds = @q.result.page(params[:page])
    end
  end

  def add_feed_tags
    tags = params['feed']['tag_list']
    feed = Feed.find params[:id]
    feed.tag_list = tags
    feed.save
  end
end

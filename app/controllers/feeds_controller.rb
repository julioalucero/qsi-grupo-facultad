class FeedsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @q = Feed.search(params[:q])
    @feeds = @q.result.page(params[:page])
  end
end

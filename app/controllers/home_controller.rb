class HomeController < ApplicationController

  before_filter :authenticate_user!

  def index
    @users = User.all
    @feeds = Feed.page params[:page]
  end
end

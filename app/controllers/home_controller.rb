class HomeController < ApplicationController
  def index
    @tweets = Tweet.all
    @users = User.all
  end
end

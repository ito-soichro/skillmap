class LikesController < ApplicationController
  # before_action :set_dream

  def create
    @like = current_user.likes.create(tweet_id: params[:tweet_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @like = current_user.likes.find_by(tweet_id: @tweet.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end


end



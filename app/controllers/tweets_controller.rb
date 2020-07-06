class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  #ログインしていないユーザー以外は、indexアクション以外アクセスできなくなる
  before_action :move_to_index, except: [:index, :show, :search]


  def index
    @tweets = Tweet.all
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end

  def search
    @tweets = Tweet.search(params[:keyword])
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    if @tweet.save
      redirect_to tweet_path(@tweet), notice: '投稿に成功しました。'
    else
     render :new
    end
  end

  def edit
    @tweet = Tweet.find(params[:id])
    if @tweet.user != current_user
      redirect_to tweets_path, alert: '不正なアクセスです'
    end
  end

  def update
    @tweet = Tweet.find(params[:id])
    if@tweet.update(tweet_params)
      redirect_to tweet_path(@tweet),notice: '更新に成功しました。'
    else
      render :edit
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to tweets_path
  end

  private
  def tweet_params
    params.require(:tweet).permit(:title, :body, :image)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end

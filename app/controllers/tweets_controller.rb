class TweetsController < ApplicationController
  before_action :authenticate_user!
  def index
    @input_tweet = params[:id]? Tweet.find(params[:id]) : Tweet.new
    # @q = Tweet.search(params[:q])
    @tweets = @q.result(distinct: true).includes(:user).not_reply.order('updated_at DESC').page(params[:page])
    
    if params[:reply_tweet_id]
      @reply_tweet = Tweet.find(params[:reply_tweet_id])
    end
  end
  def show
    @tweet = Tweet.find(params[:id])
  end
  def new
  end
  def edit
    @tweet = Tweet.find(params[:id])
  end
  def create
    tweet = Tweet.new
    tweet.attributes = input_tweet_param
    tweet.user_id = current_user.id
    if tweet.valid?
      tweet.save!
    else
      flash[:alert] = tweet.errors.full_messages
    end
    redirect_to action: :index
  end
  def update
    tweet = Tweet.find(params[:id])
    tweet.attributes = input_tweet_param
    if tweet.valid?
      tweet.save!
    else
      flash[:alert] = tweet.errors.full_messages
    end
    redirect_to action: :edit
  end
  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to action: :index, notice: "ツイートを削除しました。"
  end
  private
  def input_tweet_param
    params.require(:tweet).permit(:content, :reply_tweet_id)
  end
end

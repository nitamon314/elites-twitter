class TweetsController < ApplicationController
  def index
    @input_tweet = params[:id]? Tweet.find(params[:id]) : Tweet.new
    @tweet = Tweet.includes(:user).order('updated_at DESC').page(params[:page])
   
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
    redirect_to action: :index
  end
  def destroy
  end
  private
  def input_tweet_param
    params.require(:tweet).permit(:content)
  end
end

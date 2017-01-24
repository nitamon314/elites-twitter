module TweetsHelper
    def mytweet?(tweet)
        tweet.user.id == current_user.id
    end
end

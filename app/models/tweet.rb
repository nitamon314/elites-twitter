class Tweet < ActiveRecord::Base
    belongs_to :user
    has_many :replies, class_name: 'Tweet', foreign_key: 'reply_tweet_id'
    
    paginates_per 10
    
    validates :content, presence: true, allow_blank: false, length: { maximum: 140 }
    
    scope :not_reply, -> do
        where(reply_tweet_id: nil)
    end
end

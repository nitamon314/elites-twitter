class Tweet < ActiveRecord::Base
    belongs_to :user
    
    paginates_per 10
    
    validates :content, presence: true, allow_blank: false
    
end

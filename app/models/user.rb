class User < ActiveRecord::Base
  has_many :tweets
  paginates_per 10
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  mount_uploader :image, UserImageUploader
  validates :name, presence: true, uniqueness: true
  validates :profile, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  # validate :check_image
  
  # private
  # def check_image
  #   if @uploaded_image
  #     if data.size > 500.kilobytes
  #       errors.add(:uploaded_image, :too_big_image)
  #     end
  #     unless IMAGE_TYPES.has_key?(content_type)
  #       errors.add(:uploaded_image, :invalid_image)
  #     end
  #   end
  # end
end

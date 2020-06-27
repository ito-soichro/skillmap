class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image      
  has_many :tweets, dependent: :destroy
  has_many :comments
  has_many :likes, dependent: :destroy
  validates :username, presence: true 

  def already_liked?(tweet)
    self.likes.exists?(tweet_id: tweet.id)
  end
    
end

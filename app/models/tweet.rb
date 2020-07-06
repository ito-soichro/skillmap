class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes, dependent: :destroy
  attachment :image 

  def self.search(search)
    if search
      Tweet.where('title LIKE(?)', "%#{search}%")
    else
      Tweet.all
    end
  end

  with_options presence: true do
    validates :title
    validates :body
    validates :image
  end
  
end

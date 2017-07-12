class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  belongs_to :user
  has_many :likes, dependent: :destroy

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

  scope :matching_keyword, -> (searchword){ where("title LIKE?", "%#{searchword}%") }
end

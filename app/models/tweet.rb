class Tweet < ApplicationRecord
  belongs_to :user
  has_many :favorites

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  has_many :comments, dependent: :destroy

  scope :like_body, -> (body)  {
    where("body LIKE ?", "%#{body}%")
  }

  mount_uploader :img, ImgUploader

end
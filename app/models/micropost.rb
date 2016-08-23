class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length:{maximum:140}
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validate :picture_size

  def picture_size
    if picture.size > 5.megabytes
      error.add(:picture, "should be less the 5MB")
    end

  end
end

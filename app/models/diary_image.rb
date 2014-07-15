class DiaryImage < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true

  mount_uploader :image, DiaryImageUploader
end

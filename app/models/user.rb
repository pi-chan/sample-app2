class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :diaries, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_diaries, through: :likes, source: :diary

  mount_uploader :profile_image, ProfileImageUploader

  def display_name
    name.presence || email
  end
end









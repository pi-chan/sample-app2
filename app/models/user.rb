class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :name, presence: true

  has_many :diaries, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_diaries, through: :likes, source: :diary
  has_many :comments, foreign_key: "commenter_id", dependent: :destroy
  has_one :cart, dependent: :destroy
  has_many :purchases
  has_many :diary_images, dependent: :destroy

  mount_uploader :profile_image, UploaderBase

  after_create :create_cart_if_not_exists

  private

  def create_cart_if_not_exists
    create_cart unless cart
  end
end



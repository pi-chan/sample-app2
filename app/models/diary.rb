class Diary < ActiveRecord::Base

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true

  default_scope { order(created_at: :desc) }

  def htmlized_body
    "<div>#{body}</div>".html_safe
  end

end

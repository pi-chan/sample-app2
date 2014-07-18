class Diary < ActiveRecord::Base

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true

  default_scope { order(created_at: :desc) }

  paginates_per 10

  def htmlized_body
    "<div>#{body}</div>".gsub("\n", "<br />").html_safe
  end

end

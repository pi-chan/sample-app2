class Diary < ActiveRecord::Base

  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true

  default_scope { order(created_at: :desc) }

  def htmlized_body
    "<div>#{body}</div>".html_safe
  end

end

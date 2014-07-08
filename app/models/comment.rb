class Comment < ActiveRecord::Base
  belongs_to :diary
  belongs_to :commenter, class_name: "User"

  validates :body, presence: true

  def htmlized_body
    "<div>#{body}</div>".gsub("\n", "<br />").html_safe
  end
  
end

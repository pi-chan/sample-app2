module UsersHelper
  def link_to_user(user, display_text = nil)
    link_to (display_text || user.name), user_diaries_path(user)
  end
end

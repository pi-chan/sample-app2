# -*- coding: utf-8 -*-
class UserMailer < ActionMailer::Base
  default from: "notify@sakuramarket.com"

  def like(like_object)
    @liker = like_object.user
    @diary = like_object.diary
    @user = @diary.user
    mail to: @user.email, subject: "あなたの日記にGood!が付きました"
  end

  def comment(comment_object)
    @commenter = comment_object.commenter
    @diary = comment_object.diary
    @user = @diary.user
    mail to: @user.email, subject: "あなたの日記にコメントが追加されました"
  end
    
end

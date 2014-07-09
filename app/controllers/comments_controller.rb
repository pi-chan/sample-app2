# -*- coding: utf-8 -*-
class CommentsController < ApplicationController

  before_action :sign_in_required
  before_action :set_user_and_diary
  before_action :current_user_required, only: [:edit, :update, :destroy]
  
  def create
    @comment = @diary.comments.new(comment_params)
    @comment.commenter_id = current_user.id

    if @comment.save
      UserMailer.comment(@comment).deliver if @user != @comment.commenter
      redirect_to user_diary_url(@user, @diary), notice: "コメントが追加されました"
    else
      render "diaries/show"
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to user_diary_url(@user, @diary), notice: "コメントが更新されました"
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to user_diary_url(@user, @diary), notice: "コメントを削除しました"
  end

  private

  def set_user_and_diary
    @user = User.find_by_id(params[:user_id])
    @diary = Diary.find_by_id(params[:diary_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  # override
  def current_user_required
    @comment = Comment.find_by_id(params[:id])
    redirect_to user_diary_path(@user, @diary) if (@comment.commenter != current_user) or !@comment
  end
end

class LikesController < ApplicationController

  before_action :sign_in_required
  before_action :set_user_and_diary
  
  def create
    if @user.id == current_user.id and @diary.user.id != @user.id
      @like = @user.likes.create(diary_id: @diary.id)
      UserMailer.like(@like).deliver
    else
      render nothing: true
    end
  end

  def destroy
    if @user.id == current_user.id
      @like = Like.find_by_user_id_and_diary_id(@user.id, @diary.id)
      @like.destroy if @like
    else
      render nothing: true
    end
  end

  private

  def set_user_and_diary
    @user = User.find_by_id(params[:user_id])
    @diary = Diary.find_by_id(params[:diary_id])
  end
  
end

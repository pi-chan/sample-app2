# -*- coding: utf-8 -*-
class DiariesController < ApplicationController

  before_action :sign_in_required
  before_action :current_user_required, only: [:new, :edit, :create, :update, :destroy ]
  before_action :set_diary, only: [:edit, :update, :destroy]

  def index
    @user = User.find(params[:user_id])
    @diaries = @user.diaries.page(params[:page])
  end

  def show
    @user = User.find(params[:user_id])
    @diary = Diary.find(params[:id])
    @comment = Comment.new
  end

  def new
    @diary = current_user.diaries.new
  end

  def edit
  end

  def create
    @diary = current_user.diaries.new(diary_params)
    if @diary.save
      redirect_to( {action: :index}, notice:"日記を投稿しました")
    else
      render :new
    end
  end

  def update
    if @diary and @diary.update(diary_params)
      redirect_to [current_user, @diary], notice: "日記を更新しました"
    else
      render :edit
    end
  end

  def destroy
    if @diary
      @diary.destroy
      redirect_to( {action: :index}, notice:"日記を削除しました")
    else
      redirect_to( {action: :index}, notice:"削除する日記がありませんでした")
    end
  end

  private

  def diary_params
    params.require(:diary).permit(:title, :body)
  end

  def set_diary
    @diary = current_user.diaries.find_by_id(params[:id])
  end

  def current_user_required
    @user = User.find(params[:user_id])
    redirect_to root_url if @user != current_user
  end
  
end

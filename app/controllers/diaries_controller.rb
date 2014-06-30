# -*- coding: utf-8 -*-
class DiariesController < ApplicationController

  before_filter :sign_in_required

  def index
    @diaries = @user.diaries
  end

  def show
  end

  def new
    @diary = current_user.diaries.new
  end

  def edit
  end

  def create
    @diary = current_user.diaries.new(permitted_params)
    if @diary.save
      redirect_to( {action: :index}, notice:"日記を投稿しました")
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private

  def permitted_params
    params.require(:diary).permit(:title, :body)
  end
  
end

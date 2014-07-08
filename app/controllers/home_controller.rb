class HomeController < ApplicationController
  def index
    @user = current_user
    @diaries = Diary.page(params[:page])
  end
end

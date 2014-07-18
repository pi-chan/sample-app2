class DiaryImagesController < ApplicationController

  before_action :sign_in_required
  before_action :current_user_required
  
  def index
    @diary_images = @user.diary_images.page(params[:page])
  end

  def create
    @diary_image = @user.diary_images.new
    @diary_image.image = params[:files].try(:first) || params[:file]
    if @diary_image.save
      tag = "\n<div><a href='#{@diary_image.image.url}' target='_blank'><img src='#{@diary_image.image.medium.url}' /></a></div>\n"
      render json: { tag: tag }
    else
      render nothing: true, status: 500
    end
  end

  def destroy
    @image = @user.diary_images.find_by_id(params[:id])
    @image.destroy
    redirect_to user_diary_images_url(@user)
  end
end

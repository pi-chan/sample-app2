# -*- coding: utf-8 -*-
class UsersController < ApplicationController

  before_action :sign_in_required, :set_and_check_user
  
  def edit
  end

  def update
    current_password = params[:user].delete(:current_password)
    valid_password = @user.valid_password?(current_password)
    @user.errors.add("現在のパスワード", "正しいパスワードを入力してください") unless valid_password
    
    if valid_password and @user.update(user_params)
      redirect_to edit_user_url(@user), notice: "ユーザー情報を更新しました"
    else
      render :edit
    end
  end

  def remove_profile
    @user.remove_profile_image!
    @user.save
    redirect_to edit_user_url(@user), notice: "プロフィール画像を削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :ship_name, :ship_zip_code, :ship_address, :profile_image)
  end

  def set_and_check_user
    @user = User.find_by_id(params[:id])
    redirect_to new_user_session_url if @user.id != current_user.id
  end
  
end

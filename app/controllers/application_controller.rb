# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def sign_in_required
    store_location
    redirect_to new_user_session_url unless user_signed_in?
  end

  def current_user_required
    @user = User.find(params[:user_id])
    redirect_to root_url if @user != current_user
  end

  def store_location
    return unless request.get? 
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/sign_out" &&
        !request.xhr?)
      session[:previous_url] = request.fullpath 
    end
  end

  def after_sign_in_path_for(resource)
    if current_user.name.empty?
      flash[:notice] = "便利に使うためにニックネームを入力しましょう"
      edit_user_registration_path
    else
      session[:previous_url] || root_path
    end
  end  

end

# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_variables
  before_action :configure_permitted_parameters, :if => :devise_controller?

  private

  def set_variables
    @recent_comments = Comment.last(10)
    @recent_likes = Like.last(10)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

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
    unless current_user.ship_name.present?
      flash[:notice] = "便利に使うためにお届け情報を入力しましょう"
      edit_user_path(current_user)
    else
      session[:previous_url] || root_path
    end
  end  

end

# -*- coding: utf-8 -*-
class Admins::ApplicationController < ApplicationController
  layout 'admins/layouts/application'
  before_action :admin_required

  private
  
  def admin_required
    redirect_to root_url unless current_user.try(:admin)
  end
end

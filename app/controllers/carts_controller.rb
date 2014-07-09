class CartsController < ApplicationController

  before_action :sign_in_required
  before_action :current_user_required
  
  def show
    @cart = @user.cart
  end

end

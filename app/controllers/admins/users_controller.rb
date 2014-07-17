class Admins::UsersController < Admins::ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @users = User.all.page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to admins_user_url(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admins_users_url
  end

  private

  def set_user
    @user = User.find_by_id(params[:id])
  end

  def user_params
    attributes = %I(email name ship_name ship_zip_code ship_address)
    params.require(:user).permit(attributes)
  end

end

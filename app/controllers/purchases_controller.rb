# -*- coding: utf-8 -*-
class PurchasesController < ApplicationController

  before_action :sign_in_required, :current_user_required
  before_action :load_wizard, only: [:new, :create]
  
  def index
    @purchases = @user.purchases.page(params[:page])
  end

  def show
    @purchase = @user.purchases.find_by_id(params[:id])
  end

  def new
    @purchase = @wizard.object
  end

  def create
    @purchase = @wizard.object
    if @wizard.save and @user.cart.do_purchase(@purchase)
      redirect_to [@user, @purchase], notice: "購入手続きが完了しました"
    else
      render :new
    end
  end

  private

  def load_wizard
    @wizard = ModelWizard.new(@user.purchases.new, session, params)
    if self.action_name.in? %w[new]
      @wizard.start
    elsif self.action_name.in? %w[create]
      @wizard.process
    end
  end
  
end

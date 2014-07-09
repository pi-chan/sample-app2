# -*- coding: utf-8 -*-
require 'rails_helper'

RSpec.describe CartsController, :type => :controller do

  before do
    @user = login_user
    @user2  = FactoryGirl.create(:user)
  end
  
  describe "ログイン中のユーザーで" do
    describe "自分のショッピングカートをGET 'show'" do
      it "HTTPサクセス" do
        get 'show', user_id: @user.id
        expect(response).to be_success
      end
    end

    describe "自分以外のショッピングカートをGET 'show'" do
      it "HTTPサクセス" do
        get 'show', user_id: @user2.id
        expect(response).to redirect_to(root_url)
      end
    end
  end

  
  describe "ログインしていないユーザーで" do
    before do
      sign_out @user
    end

    describe "GET 'show'" do
      it "ログインページへリダイレクトされる" do
        get 'show', user_id: @user.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end
  
end

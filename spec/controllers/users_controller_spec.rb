# -*- coding: utf-8 -*-
require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  before do
    @user = login_user
    @user2 = FactoryGirl.create(:user)
  end

  describe "ログインしているユーザーidで" do
    before do
      @old_name = @user.name
      @old_ship_name = @user.ship_name
      @old_ship_address = @user.ship_address
      @old_ship_zip_code = @user.ship_zip_code
    end
    
    describe "GET 'edit'すると" do
      it "HTTPサクセス" do
        get 'edit', id: @user.id
        expect(response).to be_success
      end
    end

    describe "PUT 'update'" do
      it "名前などが更新される" do
        put 'update', id: @user.id, user: {
          id: @user.id,
          name: "new name", ship_name: "ship name",
          ship_address: "ship_address", ship_zip_code: "zip code"
        }
        expect(@user.reload.name).not_to eq(@old_name)
        expect(@user.ship_name).not_to eq(@old_ship_name)
        expect(@user.ship_address).not_to eq(@old_ship_address)
        expect(@user.ship_zip_code).not_to eq(@old_ship_zip_code)
      end
    end

    describe "PUT 'update'でプロフィールを更新しようとすると" do
      before do
        @file = fixture_file_upload("sample.png", "image/png")
      end
      
      it "画像ファイルがアップロードされる" do
        put 'update', id: @user.id, user: {
          id: @user.id,
          profile_image: @file,
          current_password: "password"
        }
        expect(@user.reload).to be_profile_image
      end      
    end

    describe "GET 'remove_profile'すると" do
      before do
        @user.profile_image = @file
        @user.save
      end

      it "プロフィール画像が削除される" do
        get 'remove_profile', id: @user.id
        expect(@user).not_to be_profile_image
      end
    end
  end

  describe "ログインしていないユーザーidで" do
    describe "GET 'edit'すると" do
      it "ログインページにリダイレクトされる" do
        get 'edit', id: @user2.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "PUT update'すると" do
      it "ログインページにリダイレクトされる" do
        put 'update', id: @user2.id, user: {id: @user2.id}
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "GET 'remove_profile'すると" do
      it "ログインページにリダイレクトされる" do
        get 'remove_profile', id: @user2.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end
    
  end

  describe "ログインしていないとき" do
    before do
      sign_out @user
    end

    describe "GET 'edit'すると" do
      it "ログインページにリダイレクトされる" do
        get 'edit', id: @user.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "PUT update'" do
      it "ログインページにリダイレクトされる" do
        put 'update', id: @user.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end
    
  end  

end

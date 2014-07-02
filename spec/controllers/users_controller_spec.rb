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

    describe "PUT 'update'すると" do
      it "HTTPサクセス" do
        put 'update', id: @user.id, user: {id: @user.id}
        expect(response).to be_success
      end
    end

    describe "PUT 'update'でパスワードなしで名前を更新しようとすると" do
      it "名前が更新されない" do
        put 'update', id: @user.id, user: {id: @user.id, name: "name"}
        expect(@user.reload.name).to eq(@old_name)
      end
    end

    describe "PUT 'update'でパスワードありで更新しようとすると" do
      it "名前が更新される" do
        put 'update', id: @user.id, user: {
          id: @user.id,
          name: "name", ship_name: "ship name",
          ship_address: "ship_address", ship_zip_code: "zip code",
          current_password: "password"
        }
        expect(@user.reload.name).not_to eq(@old_name)
        expect(@user.ship_name).not_to eq(@old_ship_name)
        expect(@user.ship_address).not_to eq(@old_ship_address)
        expect(@user.ship_zip_code).not_to eq(@old_ship_zip_code)
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

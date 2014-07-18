# -*- coding: utf-8 -*-
require 'rails_helper'

shared_examples_for 'ルートにリダイレクトされる場合' do
  before do
    @existing_user = FactoryGirl.create(:user)
  end

  describe "GET 'index'" do
    it "ルートにリダイレクトされる" do
      get 'index'
      expect(response).to redirect_to(root_url)
    end
  end

  describe "GET 'show'" do
    it "ルートにリダイレクトされる" do
      get 'show', id: @existing_user.id
      expect(response).to redirect_to(root_url)
    end
  end

  describe "GET 'edit'" do
    it "ルートにリダイレクトされる" do
      get 'edit', id: @existing_user.id
      expect(response).to redirect_to(root_url)
    end
  end

  describe "PUT 'update'" do
    it "ルートにリダイレクトされる" do
      put 'update', id: @existing_user.id
      expect(response).to redirect_to(root_url)
    end
  end

  describe "DELETE 'destroy'" do
    it "ルートにリダイレクトされる" do
      delete 'destroy', id: @existing_user.id
      expect(response).to redirect_to(root_url)
    end
  end
end

RSpec.describe Admins::UsersController, :type => :controller do

  describe "管理者ユーザーでログインしている場合" do
    before do
      @admin = login_admin
      @existing_user = FactoryGirl.create(:user)
    end

    describe "GET 'index'" do
      it "HTTPサクセス" do
        get 'index'
        expect(response).to be_success
      end
    end

    describe "GET 'show'" do
      it "HTTPサクセス" do
        get 'show', id: @existing_user.id
        expect(response).to be_success
      end
    end

    describe "GET 'edit'" do
      it "HTTPサクセス" do
        get 'edit', id: @existing_user.id
        expect(response).to be_success
      end
    end

    describe "PUT 'update'" do
      before do
        @old_name = @existing_user.name
        @old_ship_name = @existing_user.ship_name
        @old_ship_zip_code = @existing_user.ship_zip_code
        @old_ship_address = @existing_user.ship_address
      end

      it "属性が更新される" do
        put 'update', id: @existing_user.id,
        user: {
          name: "new name", ship_name: "ship name",
          ship_address: "ship_address", ship_zip_code: "zip code"
        }

        expect(@existing_user.reload.name).not_to eq(@old_name)
        expect(@existing_user.ship_name).not_to eq(@old_ship_name)
        expect(@existing_user.ship_address).not_to eq(@old_ship_address)
        expect(@existing_user.ship_zip_code).not_to eq(@old_ship_zip_code)
      end
    end

    describe "DELETE 'destroy'" do
      it "ユーザー一覧にリダイレクトされる" do
        delete 'destroy', id: @existing_user.id
        expect(response).to redirect_to admins_users_url
      end

      it "ユーザーが1人減る" do
        expect do
          delete 'destroy', id: @existing_user.id
        end.to change(User, :count).by(-1)
      end
    end
    
  end

  describe "通常ユーザーでログインしている場合" do
    before do
      @user = login_user
    end

    it_behaves_like "ルートにリダイレクトされる場合"
  end

  describe "ログインしていない場合" do
    it_behaves_like "ルートにリダイレクトされる場合"
  end
  
end

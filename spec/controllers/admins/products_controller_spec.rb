# -*- coding: utf-8 -*-
require 'rails_helper'

shared_examples_for 'ルートにリダイレクトされる場合' do
  describe "GET 'index'" do
    it "ルートにリダイレクトされる" do
      get 'index'
      expect(response).to redirect_to(root_url)
    end
  end

  describe "GET 'show'" do
    it "ルートにリダイレクトされる" do
      get 'show', id: @product.id
      expect(response).to redirect_to(root_url)
    end
  end

  describe "GET 'new'" do
    it "ルートにリダイレクトされる" do
      get 'new'
      expect(response).to redirect_to(root_url)
    end
  end
  
  describe "POST 'create'" do
    it "ルートにリダイレクトされる" do
      get 'create'
      expect(response).to redirect_to(root_url)
    end
  end
  
  describe "GET 'edit'" do
    it "ルートにリダイレクトされる" do
      get 'edit', id: @product.id
      expect(response).to redirect_to(root_url)
    end
  end

  describe "PUT 'update'" do
    it "ルートにリダイレクトされる" do
      put 'update', id: @product.id
      expect(response).to redirect_to(root_url)
    end
  end

  describe "DELETE 'destroy'" do
    it "ルートにリダイレクトされる" do
      delete 'destroy', id: @product.id
      expect(response).to redirect_to(root_url)
    end
  end
end

RSpec.describe Admins::ProductsController, :type => :controller do

  before do
    @product = FactoryGirl.create(:product)
  end

  describe "管理者ユーザーでログインしている場合" do
    before do
      @admin = login_admin
    end

    describe "GET 'index'" do
      it "HTTPサクセス" do
        get 'index'
        expect(response).to be_success
      end
    end

    describe "GET 'show'" do
      it "HTTPサクセス" do
        get 'show', id: @product.id
        expect(response).to be_success
      end
    end

    describe "GET 'new'" do
      it "HTTPサクセス" do
        get 'new'
        expect(response).to be_success
      end
    end
    
    describe "GET 'edit'" do
      it "HTTPサクセス" do
        get 'edit', id: @product.id
        expect(response).to be_success
      end
    end

    describe "POST 'create'" do
      before do
        @params = {
          name: "newname", price: 10000,
          description: "hogehogehoge",
          image: fixture_file_upload("sample.png", "image/png")
        } 
      end
      
      it "画像がないと登録できない" do
        @params.delete(:image)
        post 'create', product: @params
        expect(response).to render_template(:new)
      end

      describe "正しいパラメータを与えると" do
        it "登録できる" do
          post 'create', product: @params
          expect(response).to redirect_to admins_product_url(Product.last)
        end

        it "商品が一つ増える" do
          expect do
            post 'create', product: @params
          end.to change(Product, :count).by(1)
        end
      end
    end

    describe "PUT 'update'" do
      before do
        @old_name = @product.name
        @old_price = @product.price
        @old_desc = @product.description
      end

      it "属性が更新される" do
        put 'update', id: @product.id,
        product: {
          name: "newname", price: 99999, description:"newdesc"
        }

        expect(@product.reload.name).not_to eq(@old_name)
        expect(@product.price).not_to eq(@old_price)
        expect(@product.description).not_to eq(@old_desc)
      end
    end

    describe "DELETE 'destroy'" do
      it "商品管理画面にリダイレクトされる" do
        delete 'destroy', id: @product.id
        expect(response).to redirect_to admins_products_url
      end

      it "商品が1つ減る" do
        expect do
          delete 'destroy', id: @product.id
        end.to change(Product, :count).by(-1)
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

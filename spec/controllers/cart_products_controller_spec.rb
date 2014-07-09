# -*- coding: utf-8 -*-
require 'rails_helper'

RSpec.describe CartProductsController, :type => :controller do
  
  before do
    @user = login_user
    @user2 = FactoryGirl.create(:user)
    @product = FactoryGirl.create(:product)
    @params = {cart_id:  @user.cart.id, product_id: @product.id, amount: 1}
  end
  
  describe "ログイン中のユーザーで" do
    describe "POST 'create'" do
      it "カートページへリダイレクトされる" do
        post 'create', user_id: @user.id, cart_product: @params
        expect(response).to redirect_to(user_cart_url(@user))
      end

      it "カート内商品の種類が1増える" do
        expect do
          post 'create', user_id: @user.id, cart_product: @params
        end.to change(@user.cart.products, :count).by(1)
      end

      it "すでにカートにある商品の場合、カート内の該当商品数が1増える" do
        @cart_product = @product.cart_products.create(cart_id: @user.cart.id, amount: 1)
        post 'create', user_id: @user.id, cart_product: @params
        expect(@cart_product.reload.amount).to eq(2)
      end
      
    end

    describe "自身への操作として" do
      before do
        @cart_product = @product.cart_products.create(cart_id: @user.cart.id, amount: 1)
      end
      
      describe "PUT 'update'" do
        it "カートページへリダイレクトされる" do
          put 'update', user_id: @user.id, id: @product.id, cart_product: @params
          expect(response).to redirect_to(user_cart_url(@user))
        end

        it "amountがマイナスだとショッピングカートを表示" do
          put 'update', user_id: @user.id, id: @product.id, cart_product: @params.merge(amount:-1)
          expect(response).to render_template("carts/show")
        end

        it "amountがゼロだと削除される" do
          expect do
            put 'update', user_id: @user.id, id: @product.id, cart_product: @params.merge(amount:0)
          end.to change(CartProduct, :count).by(-1)
        end
        
      end
      
      describe "DELETE 'destory'" do
        it "カートページへリダイレクトされる" do
          delete 'destroy', user_id: @user.id, id: @product.id, cart_product: @params
          expect(response).to redirect_to(user_cart_url(@user))
        end

        it "カート内商品の種類が1減る" do
          expect do
            delete 'destroy', user_id: @user.id, id: @product.id, cart_product: @params
          end.to change(@user.cart.products, :count).by(-1)
        end
      end
    end

    describe "POST 'create'" do
      it "ログインページへリダイレクトされる" do
        post 'create', user_id: @user2.id, cart_product: @params 
        expect(response).to redirect_to(root_url)
      end
    end

    describe "PUT update'" do
      it "ログインページへリダイレクトされる" do
        put 'update', user_id: @user2.id, id: @product.id, cart_product: @params
        expect(response).to redirect_to(root_url)
      end
    end

    describe "DELETE 'destroy'" do
      it "ログインページへリダイレクトされる" do
        delete 'destroy', user_id: @user2.id, id: @product.id, cart_product: @params
        expect(response).to redirect_to(root_url)
      end
    end
    
  end

  describe "ログインしていないユーザーで" do
    before do
      sign_out @user
    end
    
    describe "POST 'create'" do
      it "ログインページへリダイレクトされる" do
        post 'create', user_id: @user.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "PUT update'" do
      it "ログインページへリダイレクトされる" do
        put 'update', user_id: @user.id, id: @product.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "DELETE 'destroy'" do
      it "ログインページへリダイレクトされる" do
        delete 'destroy', user_id: @user.id, id: @product.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

end

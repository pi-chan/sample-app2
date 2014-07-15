# -*- coding: utf-8 -*-
require 'rails_helper'

RSpec.describe PurchasesController, :type => :controller do

  before do
    @user = login_user
    @user2 = FactoryGirl.create(:user)
    @purchase_item_count = 10
    @purchase_item_count.times { FactoryGirl.create(:product) }
    Product.all.each do |p|
      @user.cart.cart_products.create(product_id:p.id, amount:1)
    end
    @purchase = FactoryGirl.create(:purchase)
  end

  describe "ログイン中のユーザーで" do
    describe "自身のidで" do
      describe "GET 'index'" do
        it "HTTPサクセス" do
          get 'index', user_id: @user.id
          expect(response).to be_success
        end
      end

      describe "GET 'show'" do
        it "HTTPサクセス" do
          get 'show', user_id: @user.id, id: @purchase.id
          expect(response).to be_success
        end
      end

      describe "GET 'new'" do
        it "HTTPサクセス" do
          get 'new', user_id: @user.id
          expect(response).to be_success
        end
      end

      describe "POST 'create'" do
        before do
          @params = {
            ship_name: Faker::Name.name,
            ship_address: Faker::Address.city,
            ship_zip_code: Faker::Number.number(7),
            delivery_time: :t_8_12,
            delivery_date: 1.day.from_now.to_date,
            product_price: 1000,
            shipping_cost: 600,
            cash_on_delivery: 300,
            tax_percentage: 8
          }
          get 'new', user_id: @user.id
        end
        
        it "購入ページにリダイレクトされる" do
          post 'create', user_id: @user.id, purchase: @params
          purchase = @user.purchases.last
          expect(response).to redirect_to(user_purchase_url(@user, purchase))
        end

        it "Purchaseが1つ増える" do
          expect do
            post 'create', user_id: @user.id, purchase: @params
          end.to change(Purchase, :count).by(1)
        end

        it "ショッピングカートが空になる" do
          post 'create', user_id: @user.id, purchase: @params
          expect(@user.cart.cart_products.count).to eq(0)
        end

        it "PurchaseProductが10増える" do
          expect do
            post 'create', user_id: @user.id, purchase: @params
          end.to change(PurchaseProduct, :count).by(@purchase_item_count)
        end
      end
    end

    describe "自分以外のidで" do
      describe "GET 'index'" do
        it "ルートページにリダイレクトされる" do
          get 'index', user_id: @user2.id
          expect(response).to redirect_to(root_url)
        end
      end

      describe "GET 'show'" do
        it "ルートページにリダイレクトされる" do
          get 'show', user_id: @user2.id, id: @purchase.id
          expect(response).to redirect_to(root_url)
        end
      end

      describe "GET 'new'" do
        it "ルートページにリダイレクトされる" do
          get 'new', user_id: @user2.id
          expect(response).to redirect_to(root_url)
        end
      end

      describe "POST 'create'" do
        it "ルートページにリダイレクトされる" do
          post 'create', user_id: @user2.id
          expect(response).to redirect_to(root_url)
        end
      end
      
    end
  end

  describe "ログインしていないユーザーで" do
    before do
      sign_out @user
    end
    
    describe "GET 'index'" do
      it "ログインページへリダイレクトされる" do
        get 'index', user_id: @user.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "GET 'show'" do
      it "ログインページへリダイレクトされる" do
        get 'show', user_id: @user.id, id: @purchase.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "POST 'new'" do
      it "ログインページへリダイレクトされる" do
        get 'new', user_id: @user.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "GET 'create'" do
      it "ログインページへリダイレクトされる" do
        post 'create', user_id: @user.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

end

# -*- coding: utf-8 -*-
require 'rails_helper'

RSpec.describe Cart, :type => :model do
  before do
    @user = FactoryGirl.create(:user)
    @cart = @user.create_cart
    @price = 0
    allow(@cart).to receive(:product_price){@price}
  end

  describe "#cash_on_delivery" do
    it "商品合計が0円のときの手数料" do
      expect(@cart.cash_on_delivery).to eq(300)
    end

    it "商品合計が1000円のときの手数料" do
      @price = 1000
      expect(@cart.cash_on_delivery).to eq(300)
    end

    it "商品合計が10000円のときの手数料" do
      @price = 10000
      expect(@cart.cash_on_delivery).to eq(400)
    end

    it "商品合計が30000円のときの手数料" do
      @price = 30000
      expect(@cart.cash_on_delivery).to eq(600)
    end

    it "商品合計が100000円のときの手数料" do
      @price = 100000
      expect(@cart.cash_on_delivery).to eq(1000)
    end

    it "商品合計が1000000円のときの手数料" do
      @price = 1000000
      expect(@cart.cash_on_delivery).to eq(1000)
    end
  end
end

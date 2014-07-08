require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do
  before do
    @product = FactoryGirl.create(:product)
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: @product.id
      expect(response).to be_success
    end
  end

end

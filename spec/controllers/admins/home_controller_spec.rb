# -*- coding: utf-8 -*-
require 'rails_helper'

RSpec.describe Admins::HomeController, :type => :controller do

  describe "管理者ユーザーでGET 'index'" do
    before do
      login_admin
    end
    it "HTTPサクセス" do
      get 'index'
      expect(response).to be_success
    end
  end

  describe "通常ユーザーでGET 'index'" do
    before do
      login_user
    end
    it "ルートにリダイレクトされる" do
      get 'index'
      expect(response).to redirect_to(root_url)
    end
  end
  
end

# -*- coding: utf-8 -*-
require 'rails_helper'

RSpec.describe LikesController, :type => :controller do

  before do
    @user = login_user
    @user2 = FactoryGirl.create(:user)
    @user3 = FactoryGirl.create(:user)
    @diary  = @user .diaries.create(title:"title", body:"body")
    @diary3 = @user3.diaries.create(title:"title", body:"body")
  end

  describe "ログインしているユーザーidで" do
    describe "POST 'create'すると" do
      it "HTTPサクセス" do
        post 'create', format: "js", user_id: @user.id, diary_id: @diary3.id
        expect(response).to be_success
      end
      
      it "Likeの数が増える" do
        expect do
          post 'create', format: "js", user_id: @user.id, diary_id: @diary3.id
        end.to change(Like, :count).by(1)
      end

      it "相手にメールで通知される" do
        expect do
          post 'create', format: "js", user_id: @user.id, diary_id: @diary3.id
        end.to change(ActionMailer::Base.deliveries, :size).by(1)
      end
      
    end

    describe "自分自身の日記をLikeしようとすると" do
      it "何も返さない" do
        post 'create', format: "js", user_id: @user.id, diary_id: @diary.id
        expect(response).to have_text(" ")
      end

      it "Likeの数は増えない" do
        expect do
          post 'create', format: "js", user_id: @user.id, diary_id: @diary.id
        end.not_to change(Like, :count)
      end
    end

    describe "DELETE 'destroy'" do
      before do
        @user.likes.create(diary_id: @diary3.id)
      end
      
      it "HTTPサクセス" do
        delete 'destroy', format: "js", user_id: @user.id, diary_id: @diary3.id
        expect(response).to be_success
      end

      it "Likeの数が減る" do
        expect do
          delete 'destroy', format: "js", user_id: @user.id, diary_id: @diary3.id
        end.to change(Like, :count).by(-1)
      end
    end
  end

  describe "ログインしているユーザーのidではないidで" do
    describe "POST 'create'すると" do
      it "何も返さない" do
        post 'create', format: "js", user_id: @user2.id, diary_id: @diary3.id
        expect(response).to have_text(" ")
      end

      it "Likeの数は増えない" do
        expect do
          post 'create', format: "js", user_id: @user2.id, diary_id: @diary3.id
        end.not_to change(Like, :count)
      end
    end

    describe "DELETE 'destroy'" do
      before do
        @user2.likes.create(diary_id: @diary3.id)
      end
      
      it "Likeの数は変わらない" do
        expect do
          delete 'destroy', format: "js", user_id: @user3.id, diary_id: @diary3.id
        end.not_to change(Like, :count)
      end
    end
  end
  
  describe "ログインしていないとき" do
    before do
      sign_out @user
    end

    describe "POST 'create'すると" do
      it "ログインページにリダイレクトされる" do
        post 'create', format: "js", user_id: @user.id, diary_id: @diary3.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "delete 'destroy'" do
      it "ログインページにリダイレクトされる" do
        delete 'destroy', format: "js", user_id: @user.id, diary_id:@diary3.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

end

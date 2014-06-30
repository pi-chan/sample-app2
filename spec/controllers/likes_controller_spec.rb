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

  describe "ログイン中" do
    describe "ログインしているユーザーidでPOST 'create'すると" do
      it "HTTPサクセス" do
        post 'create', format: "js", user_id: @user.id, diary_id: @diary3.id
        expect(response).to be_success
      end

      it "Likeの数が増える" do
        expect do
        post 'create', format: "js", user_id: @user.id, diary_id: @diary3.id
        end.to change(Like, :count).by(1)
      end
    end

    describe "ログインしているユーザーのidではないidでPOST 'create'すると" do
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

    describe "ログインしているユーザーのidで自分自身の日記をLikeしようとすると" do
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
    
    describe "ログインしているユーザーidでDELETE 'destroy'すると" do
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

    describe "ログインしているユーザーのものでないLikeを消そうとすると" do
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
  # ログイン中のユーザーだけど、自分のじゃないLikeを削除しようとして失敗
  
  # ログインしていないユーザーがアクションにアクセスしてもダメ
  describe "Not signed-in user" do
    
  end

end

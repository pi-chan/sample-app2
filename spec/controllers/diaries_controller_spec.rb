# -*- coding: utf-8 -*-
require 'rails_helper'

RSpec.describe DiariesController, :type => :controller do
  before do
    @user = login_user
    @user2 = FactoryGirl.create(:user)
    @diary = @user.diaries.create(title:"title", body:"body")
    @diary2 = @user2.diaries.create(title:"title", body:"body")
  end

  describe "ログイン中" do
    describe "ログインユーザー自身に対する処理" do
      describe "GET 'index'" do
        it "HTTPサクセス" do
          get 'index', user_id: @user.id
          expect(response).to be_success
        end
      end

      describe "GET 'show'" do
        it "HTTPサクセス" do
          get 'show', user_id: @user.id, id: @diary.id
          expect(response).to be_success
        end
      end

      describe "GET 'new'" do
        it "HTTPサクセス" do
          get 'new', user_id: @user.id
          expect(response).to be_success
        end
      end

      describe "GET 'edit'" do
        it "HTTPサクセス" do
          get 'edit', user_id: @user.id, id: @diary.id
          expect(response).to be_success
        end
      end

      describe "POST 'create'する" do
        it "一覧ページ（:index）へリダイレクトされる" do
          post 'create', user_id: @user.id, diary:{title: "title", body: "body"}
          expect(response).to redirect_to(action:"index")
        end

        it "Diaryのレコードが1つ増える" do
          expect do
            post 'create', user_id: @user.id, diary:{title: "title", body: "body"}
          end.to change(Diary, :count).by(1)
        end
      end

      describe "PUT 'update'" do
        it "正しいパラメータだと日記個別ページ（:show）へリダイレクトされる" do
          put 'update', user_id: @user.id, id: @diary.id, diary:{title: "new title", body: "new body"}
          expect(response).to redirect_to(action: "show")
        end

        it "存在しない日記idを渡すと編集ページ（:edit）に戻る" do
          put 'update', user_id: @user.id, id: 999, diary:{title: "new title", body: "new body"}
          expect(response).to render_template(:edit)
        end
      end

      describe "DELETE 'destroy'" do
        it "一覧ページ（:index）へリダイレクトされる" do
          delete 'destroy', user_id: @user.id, id: @diary.id
          expect(response).to redirect_to(action: "index")
        end

        it "Diaryのレコードが1つ減る" do
          expect do
            delete 'destroy', user_id: @user.id, id: @diary.id
          end.to change(Diary, :count).by(-1)
        end
      end
    end

    describe "他ユーザーに対する処理" do

      describe "GET 'index'" do
        it "HTTPサクセス" do
          get 'index', user_id: @user2.id
          expect(response).to be_success
        end
      end

      describe "GET 'show'" do
        it "HTTPサクセス" do
          get 'show', user_id: @user2.id, id: @diary2.id
          expect(response).to be_success
        end
      end

      describe "GET 'new'" do
        it "ルートへリダイレクトされる" do
          get 'new', user_id: @user2.id
          expect(response).to redirect_to(root_url)
        end
      end

      describe "GET 'edit'" do
        it "ルートへリダイレクトされる" do
          get 'edit', user_id: @user2.id, id: @diary2.id
          expect(response).to redirect_to(root_url)
        end
      end
      
      describe "POST 'create'する" do
        it "ルートへリダイレクトされる" do
          post 'create', user_id: @user2.id, diary:{title: "title", body: "body"}
          expect(response).to redirect_to(root_url)
        end

        it "Diaryのレコードは変わらない" do
          expect do
            post 'create', user_id: @user2.id, diary:{title: "title", body: "body"}
          end.not_to change(Diary, :count)
        end
      end

      describe "PUT 'update'" do
        it "ルートへリダイレクトされる" do
          put 'update', user_id: @user2.id, id: @diary2.id, diary:{title: "new title", body: "new body"}
          expect(response).to redirect_to(root_url)
        end
      end

      describe "DELETE 'destroy'" do
        it "ルートへリダイレクトされる" do
          delete 'destroy', user_id: @user2.id, id: @diary2.id
          expect(response).to redirect_to(root_url)
        end

        it "Diaryのレコードは変わらない" do
          expect do
            delete 'destroy', user_id: @user2.id, id: @diary2.id
          end.not_to change(Diary, :count)
        end
      end
    end
  end

  describe "ログインしていないユーザー" do
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
        get 'show', user_id: @user.id, id: @diary.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "GET 'new'" do
      it "ログインページへリダイレクトされる" do
        get 'new', user_id: @user.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "GET 'edit'" do
      it "ログインページへリダイレクトされる" do
        get 'edit', user_id: @user.id, id: @diary.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "POST 'create'" do
      it "ログインページへリダイレクトされる" do
        post 'create', user_id: @user.id, diary:{title: "title", body: "body"}
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "PUT update'" do
      it "ログインページへリダイレクトされる" do
        put 'update', user_id: @user.id, id: @diary.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "DELETE 'destroy'" do
      it "ログインページへリダイレクトされる" do
        delete 'destroy', user_id: @user.id, id: @diary.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end
  
end

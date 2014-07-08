# -*- coding: utf-8 -*-
require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do

  before do
    @user = login_user
    @user2 = FactoryGirl.create(:user)
    @diary = @user.diaries.create(title:"title", body:"body")
    @comment = @diary.comments.create(commenter_id: @user.id, body: "comment")
    @comment2 = @diary.comments.create(commenter_id: @user2.id, body: "comment")
    @diary_page = user_diary_url(@user, @diary)
  end

  describe "ログイン中" do
    describe "POST 'create'" do
      it "本文が入力されていれば日記ページにリダイレクトされる" do
        post 'create', user_id: @user.id, diary_id:@diary.id, comment: { body: "body" }
        expect(response).to redirect_to(@diary_page)
      end

      it "本文が入力されていれば日記のコメントが1つ増える" do
        expect do
          post 'create', user_id: @user.id, diary_id:@diary.id, comment: { body: "body" }
        end.to change(@diary.comments, :count).by(1)
      end

      it "本文が空であれば日記ページを再度表示する" do
        post 'create', user_id: @user.id, diary_id:@diary.id, comment: { body: "" }
        expect(response).to render_template("diaries/show")
      end
    end

    describe "自分のコメントに対する操作" do
      describe "GET 'edit'" do
        it "returns http success" do
          get 'edit', user_id: @user.id, diary_id:@diary.id, id: @comment.id
          expect(response).to be_success
        end
      end

      describe "PUT 'update'" do
        it "本文が入力されていれば日記ページにリダイレクトされる" do
          put 'update', user_id: @user.id, diary_id:@diary.id, id: @comment.id, comment: {body: "new body"}
          expect(response).to redirect_to(@diary_page)
        end

        it "本文が入力されていれば日記が更新される" do
          @old_body = @comment.body
          put 'update', user_id: @user.id, diary_id:@diary.id, id: @comment.id, comment: {body: "new body"}
          expect(@comment.reload.body).not_to eq(@old_body)
        end
        
        it "本文が入力されていなければ日記編集ページを再表示する" do
          put 'update', user_id: @user.id, diary_id:@diary.id, id: @comment.id, comment: {body: ""}
          expect(response).to render_template("comments/edit")
        end

      end

      describe "DELETE 'destroy'" do
        it "日記ページにリダイレクトされる" do
          delete 'destroy', user_id: @user.id, diary_id:@diary.id, id: @comment.id
          expect(response).to redirect_to(@diary_page)
        end

        it "コメントが一件減る" do
          expect do
            delete 'destroy', user_id: @user.id, diary_id:@diary.id, id: @comment.id
          end.to change(@diary.comments, :count).by(-1)
        end
      end
    end

    describe "自分以外のコメントに対する操作" do
      describe "GET 'edit'" do
        it "日記ページにリダイレクトされる" do
          get 'edit', user_id: @user.id, diary_id:@diary.id, id: @comment2.id
          expect(response).to redirect_to(@diary_page)
        end
      end

      describe "PUT 'update'" do
        it "日記ページにリダイレクトされる" do
          put 'update', user_id: @user.id, diary_id:@diary.id, id: @comment2.id, comment:{body:"new body"}
          expect(response).to redirect_to(@diary_page)
        end
      end

      describe "DELETE 'destroy'" do
        it "日記ページにリダイレクトされる" do
          delete 'destroy', user_id: @user.id, diary_id:@diary.id, id: @comment2.id
          expect(response).to redirect_to(@diary_page)
        end
      end
    end
    
  end

  describe "ログインしていないとき" do
    before do
      sign_out @user
    end
    
    describe "GET 'edit'" do
      it "ログインページへリダイレクトされる" do
        get 'edit', user_id: @user.id, diary_id:@diary.id, id: @comment.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "POST 'create'" do
      it "ログインページへリダイレクトされる" do
        post 'create', user_id: @user.id, diary_id:@diary.id, id: @comment.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "PUT update'" do
      it "ログインページへリダイレクトされる" do
        put 'update', user_id: @user.id, diary_id:@diary.id, id: @comment.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "DELETE 'destroy'" do
      it "ログインページへリダイレクトされる" do
        delete 'destroy', user_id: @user.id, diary_id:@diary.id, id: @comment.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

end

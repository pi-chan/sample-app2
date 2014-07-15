# -*- coding: utf-8 -*-
require 'rails_helper'

RSpec.describe DiaryImagesController, :type => :controller do

  before do
    @user = login_user
    @user2 = FactoryGirl.create(:user)
    @diary_image = FactoryGirl.create(:diary_image)
  end

  describe "ログイン中のユーザー" do

    describe "自分のデータに対する処理" do
      describe "GET 'index'" do
        it "HTTPサクセス" do
          get 'index', user_id: @user.id
          expect(response).to be_success
        end
      end

      describe "画像ファイルをPOST 'create'" do
        before do
          @file = fixture_file_upload("sample.png", "image/png")
        end
        
        it "画像のURLを含んだHTMLタグがJSONで返ってくる" do
          post 'create', user_id: @user.id, file: @file
          expect(json).to have_key("tag")
        end

        it "DiaryImageが1つ増える" do
          expect do
            post 'create', user_id: @user.id, file: @file
          end.to change(DiaryImage, :count).by(1)
        end

        it "画像のURLを含んだHTMLタグがJSONで返ってくる（別パラメータ）" do
          post 'create', user_id: @user.id, filess: [@file]
          expect(json).to have_key("tag")
        end

        it "DiaryImageが1つ増える（別パラメータ）" do
          expect do
            post 'create', user_id: @user.id, files: [@file]
          end.to change(DiaryImage, :count).by(1)
        end
        
      end

      describe "画像以外のファイルをPOST 'create'" do
        before do
          @file = fixture_file_upload("sample.txt", "text/plain")
        end
        
        it "エラーが返ってくる" do
          post 'create', user_id: @user.id, file: @file
          expect(response).not_to be_success
        end
      end

      describe "DELETE 'destroy'" do
        it "indexにリダイレクトされる" do
          delete 'destroy', user_id: @user.id, id: @diary_image.id
          expect(response).to redirect_to(user_diary_images_url(@user))
        end

        it "DiaryImageが1つ減る" do
          expect do
            delete 'destroy', user_id: @user.id, id: @diary_image.id
          end.to change(DiaryImage, :count).by(-1)
        end
      end
      
    end
    
    describe "他ユーザーのデータに対する処理" do
      describe "GET 'index'" do
        it "ルートへリダイレクトされる" do
          get 'index', user_id: @user2.id
          expect(response).to redirect_to(root_url)
        end
      end

      describe "POST 'create'する" do
        it "ルートへリダイレクトされる" do
          post 'create', user_id: @user2.id
          expect(response).to redirect_to(root_url)
        end
      end

      describe "DELETE 'destroy'" do
        it "ルートへリダイレクトされる" do
          delete 'destroy', user_id: @user2.id, id: @diary_image.id
          expect(response).to redirect_to(root_url)
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

    describe "POST 'create'" do
      it "ログインページへリダイレクトされる" do
        post 'create', user_id: @user.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "DELETE 'destroy'" do
      it "ログインページへリダイレクトされる" do
        delete 'destroy', user_id: @user.id, id: @diary_image.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end
  

end

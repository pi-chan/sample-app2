require 'rails_helper'

RSpec.describe DiariesController, :type => :controller do
  before do
    @user = login_user
    @diary = @user.diaries.create(title:"title", body:"body")
  end

  describe "Signed-in user" do
    describe "GET 'index'" do
      it "returns http success" do
        get 'index', user_id: @user.id
        expect(response).to be_success
      end
    end

    describe "GET 'show'" do
      it "returns http success" do
        get 'show', user_id: @user.id, id: @diary.id
        expect(response).to be_success
      end
    end
    
    describe "GET 'new'" do
      it "returns http success" do
        get 'new', user_id: @user.id
        expect(response).to be_success
      end
    end

    describe "GET 'edit'" do
      it "returns http success" do
        get 'edit', user_id: @user.id, id: @diary.id
        expect(response).to be_success
      end
    end

    describe "POST 'create'" do
      it "is redirected to :index" do
        post 'create', user_id: @user.id, diary:{title: "title", body: "body"}
        expect(response).to redirect_to(action:"index")
      end

      it "adds a record to diaries table" do
        expect do
          post 'create', user_id: @user.id, diary:{title: "title", body: "body"}
        end.to change(Diary, :count).by(1)
      end
    end

    describe "PUT update'" do
      it "is redirected to :show" do
        put 'update', user_id: @user.id, id: @diary.id, diary:{title: "new title", body: "new body"}
        expect(response).to redirect_to(action: "show")
      end

      it "renders :edit with invalid id" do
        put 'update', user_id: @user.id, id: 999, diary:{title: "new title", body: "new body"}
        expect(response).to render_template(:edit)
      end
      
    end

    describe "DELETE 'destroy'" do
      it "is redirected to :index" do
        delete 'destroy', user_id: @user.id, id: @diary.id
        expect(response).to redirect_to(action: "index")
      end

      it "removes a record from diaries table" do
        expect do
          delete 'destroy', user_id: @user.id, id: @diary.id
        end.to change(Diary, :count).by(-1)
      end
      
    end
  end

  describe "not signed-in user" do

    before do
      sign_out @user
    end
    
    describe "GET 'index'" do
      it "is redirected to root url" do
        get 'index', user_id: @user.id
        expect(response).to redirect_to(root_url)
      end
    end

    describe "GET 'show'" do
      it "is redirected to root url" do
        get 'show', user_id: @user.id, id: @diary.id
        expect(response).to redirect_to(root_url)
      end
    end

    describe "GET 'new'" do
      it "is redirected to root url" do
        get 'new', user_id: @user.id
        expect(response).to redirect_to(root_url)
      end
    end

    describe "GET 'edit'" do
      it "is redirected to root url" do
        get 'edit', user_id: @user.id, id: @diary.id
        expect(response).to redirect_to(root_url)
      end
    end

    describe "POST 'create'" do
      it "is redirected to root url" do
        post 'create', user_id: @user.id, diary:{title: "title", body: "body"}
        expect(response).to redirect_to(root_url)
      end
    end

    describe "PUT update'" do
      it "is redirected to root url" do
        put 'update', user_id: @user.id, id: @diary.id
        expect(response).to redirect_to(root_url)
      end
    end

    describe "DELETE 'destroy'" do
      it "is redirected to root url" do
        delete 'destroy', user_id: @user.id, id: @diary.id
        expect(response).to redirect_to(root_url)
      end
    end
  end
  
end

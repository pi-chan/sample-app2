require 'rails_helper'

RSpec.describe DiariesController, :type => :controller do

  describe "Signed-in user" do
    before do
      login_user
    end
    
    describe "GET 'index'" do
      it "returns http success" do
        get 'index', user_id: 1
        expect(response).to be_success
      end
    end

    describe "GET 'show'" do
      it "returns http success" do
        get 'show', user_id: 1, id: 1
        expect(response).to be_success
      end
    end
    
    describe "GET 'new'" do
      it "returns http success" do
        get 'new', user_id: 1
        expect(response).to be_success
      end
    end

    describe "GET 'edit'" do
      it "returns http success" do
        get 'edit', user_id: 1, id: 1
        expect(response).to be_success
      end
    end

    describe "POST 'create'" do
      it "is redirected to :index" do
        post 'create', user_id: 1, diary:{title: "title", body: "body"}
        expect(response).to redirect_to(action:"index")
      end
    end

    describe "PUT update'" do
      it "returns http success" do
        put 'update', user_id: 1, id: 1
        expect(response).to be_success
      end
    end

    describe "DELETE 'destroy'" do
      it "returns http success" do
        delete 'destroy', user_id: 1, id: 1
        expect(response).to be_success
      end
    end
  end

  describe "not signed-in user" do
    describe "GET 'index'" do
      it "is redirected to root url" do
        get 'index', user_id: 1
        expect(response).to redirect_to(root_url)
      end
    end

    describe "GET 'show'" do
      it "is redirected to root url" do
        get 'show', user_id: 1, id: 1
        expect(response).to redirect_to(root_url)
      end
    end

    describe "GET 'new'" do
      it "is redirected to root url" do
        get 'new', user_id: 1
        expect(response).to redirect_to(root_url)
      end
    end

    describe "GET 'edit'" do
      it "is redirected to root url" do
        get 'edit', user_id: 1, id: 1
        expect(response).to redirect_to(root_url)
      end
    end

    describe "POST 'create'" do
      it "is redirected to root url" do
        post 'create', user_id: 1, diary:{title: "title", body: "body"}
        expect(response).to redirect_to(root_url)
      end
    end

    describe "PUT update'" do
      it "is redirected to root url" do
        put 'update', user_id: 1, id: 1
        expect(response).to redirect_to(root_url)
      end
    end

    describe "DELETE 'destroy'" do
      it "is redirected to root url" do
        delete 'destroy', user_id: 1, id: 1
        expect(response).to redirect_to(root_url)
      end
    end
  end
  
end

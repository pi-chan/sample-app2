require 'rails_helper'

RSpec.describe Like, :type => :model do
  before do
    @user1 = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
    @diary = @user1.diaries.create(title:"title", body:"body")
  end

  describe "user#likes#create" do
    it "increases diary's liker count" do
      expect do
        @user2.likes.create(diary_id: @diary.id)
      end.to change(@diary.likers, :count).by(1)
    end
  end

  describe "diary#likes#create" do
    it "increases user's liker count" do
      expect do
        @diary.likes.create(user_id: @user2.id)
      end.to change(@user2.like_diaries, :count).by(1)
    end
  end

  describe "Dependency" do
    before do
      @diary.likes.create(user_id: @user2.id)
    end
    
    specify "User#destroy decreases like's count" do
      expect do
        @user2.destroy
      end.to change(Like, :count).by(-1)
    end

    specify "Diary#destroy decreases like's count" do
      expect do
        @diary.destroy
      end.to change(Like, :count).by(-1)
    end
  end
  
end

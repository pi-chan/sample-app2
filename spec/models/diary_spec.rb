require 'rails_helper'

RSpec.describe Diary, :type => :model do

  before do
    @diary = Diary.new(user_id:1, title: "title", body: "body")
  end

  subject {@diary}
  
  describe "with DB"
    it "raises AR error without user ID" do
      expect do
        @diary.user_id = nil
        @diary.save(validate:false)
      end.to raise_error(ActiveRecord::StatementInvalid)
    end
  
end

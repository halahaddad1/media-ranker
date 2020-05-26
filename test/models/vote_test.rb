require "test_helper"

describe Vote do
  before do
    @votes = Vote.all
    end
  
  it "can be instantiated" do
    expect(@votes.first.valid?).must_equal true
    expect(@votes.first).must_be_instance_of Vote
    expect(@votes.first).wont_be_nil
  end
  
  it "will have all required fields" do
    expect(@votes.first.user_id).wont_be_nil
    expect(@votes.first.work_id).wont_be_nil
  end
  
  describe "relationships" do
    it "has relationships with Work and User" do
      expect(@votes.first.work).must_be_instance_of Work
      expect(@votes.first.user).must_be_instance_of User
    end
  end
  
  describe "validations" do
    it "must have a user_id" do
      invalid_vote1 = Vote.create(user: nil, work: Work.all.first)

      expect(invalid_vote1.valid?).must_equal false
      expect(invalid_vote1.errors.messages).must_include :user
      expect(invalid_vote1.errors.messages[:user]).must_equal ["must exist"]
    end

    it "must have a work_id" do
      invalid_vote2 = Vote.create(user: User.all.first, work: nil)

      expect(invalid_vote2.valid?).must_equal false
      expect(invalid_vote2.errors.messages).must_include :work
      expect(invalid_vote2.errors.messages[:work]).must_equal ["must exist"]
    end
  end
end

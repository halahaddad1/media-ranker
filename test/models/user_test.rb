require "test_helper"

describe User do
  before do
  @users = User.all
  end
  
  it "can be instantiated" do
    expect(@users.first.valid?).must_equal true
    expect(@users.first).must_be_instance_of User
    expect(@users.first).wont_be_nil
  end

  it "must have all the required fields" do
    expect(@users.first).must_respond_to :username
  end

  describe "relationships" do
    it "can have many votes" do
      @sample_work = Work.create(category:"movie",title: 'test movie', creator: "test creator",publication_year: "test date",description: "test description")
      @sample_vote1 = Vote.create(work_id: @sample_work.id, user_id: @users.first.id)
      @sample_vote2 = Vote.create(work_id: @sample_work.id, user_id: @users.last.id)
      
      expect(@sample_work.votes.count).must_equal 2
      @sample_work.votes.each do |vote|
      expect(@sample_vote1).must_be_instance_of Vote
      end
    end
  end

  describe "validations" do
    it "must fill all fields" do
      @example_user = User.create(username: "")

      expect(@example_user.errors.messages[:username]).must_equal ["can't be blank"]
      expect(@example_user.valid?).must_equal false
      expect(@example_user.errors.messages).must_include :username
    end

    it "has a unique title" do
      @example_user2 = User.create(username: "user")
      @example_user3 = User.create(username: "user")

      expect(@example_user3.errors.messages[:username]).must_equal ["has already been taken"]
      expect(@example_user3.valid?).must_equal false
      expect(@example_user3.errors.messages).must_include :username
    end
  end
end
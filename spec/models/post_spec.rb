require 'rails_helper'

RSpec.describe Post, type: :model do
  
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
  
  # create a parent topic for 'post'
  let(:topic) { Topic.create!(name: name, description: description) }
  
  # create a user to associate with a test post
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  
  # associate 'user' with 'post' when we create the test post
  # associate 'post' with 'topic' through 'topic.posts.create!'
  # it's a chained method call for creates a post for a given topic
  let(:post) { topic.posts.create!(title: title, body: body, user: user) }
  
  it { is_expected.to have_many(:comments) }
  
  # to test the association between posts and vote
  it { is_expected.to have_many(:votes) }
  
  it { is_expected.to belong_to(:topic) }
  it { is_expected.to belong_to(:user) }
  
  # use to make sure that 'Post' the data of 'title', 'body', 'topic', 'user' is exist
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:topic) }
  it { is_expected.to validate_presence_of(:user) }

  # to test the minimum length of 'title' and 'body'
  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(20) }

  # make sure that 'post' has two attribute: 'title' and 'body'
  describe "attributes" do
      it "has a title, body, and user attribute" do
          expect(post).to have_attributes(title: title, body: body, user: user)
      end
  end
  
  describe "voting" do
    #create 3 up votes and 2 down votes for test
    before do
      3.times { post.votes.create!(value: 1) }
      2.times { post.votes.create!(value: -1) }
      @up_votes = post.votes.where(value: 1).count
      @down_votes = post.votes.where(value: -1).count
    end
    
    # make sure that "up_votes" returns the count of up vote
    describe "#up_votes" do
      it "　counts the number of votes with value = 1" do
        expect( post.up_votes ).to eq(@up_votes)
      end
    end
    
    # make sure that "down_votes" returns the count of down vote
    describe "#down_votes" do
      it "counts the number of votes with value = -1" do
        expect( post.down_votes ).to eq(@down_votes)
      end
    end
    
    # make sure that 'point' returns the sum of all votes on the post
    describe "#points" do
      it "returns the sum of all down and up votes" do
        expect( post.points ).to eq(@up_votes - @down_votes)
      end
    end
    
    describe "#update_rank" do
      # make sure that a post's rank will be determined by the following calculation:
      # 1. use 'created_at'(a standard time in this context is known as an 'epoch') to determine the age of the post
      # 2. use '/ 1.day.seconds' to divide the age in seconds, because the epoch is set by the number of seconds. the result will become days
      # 3. use 'post.point' to add the points (sum of the votes) to the age. It will -1 vote for every passed days
      # this way will keep the post rinks very fresh. It won't have a high;y ranked but out-of-date post to be on the top of list for years
      it "calculates the correct rank" do
        post.update_rank
        expect(post.rank).to eq (post.points + (post.created_at - Time.new(1970,1,1)) / 1.day.seconds)
      end
       
      it "updates the rank when an up vote is created" do
        old_rank = post.rank
        post.votes.create!(value: 1)
        expect(post.rank).to eq (old_rank + 1)
      end
      
      it "updates the rank when a down vote is created" do
        old_rank = post.rank
        post.votes.create!(value: -1)
        expect(post.rank).to eq (old_rank - 1)
      end
    end
  end
  
  describe "create vote" do
    it "sets the post up vote to 1" do
      expect(post.up_votes).to eq(1)
    end
    
    it "calls create vote when a post is create" do
      post = topic.posts.new(title: RandomData.random_sentence, body: RandomData.random_sentence, user: user )
      expect(post).to receive(:create_vote)
      post.save
    end
    
    it "associates the vote with the owner of the post" do
      expect(post.votes.first.user).to eq(post.user)
    end
  end
end
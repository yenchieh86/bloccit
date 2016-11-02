require 'rails_helper'

# need to associated with the 'User' and 'Post'
RSpec.describe Vote, type: :model do
    let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
    let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "jack4930") }
    let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
    let(:vote) { Vote.create!(value: 1, post: post, user: user) }
    
    # make sure the votes belong to posts and user
    it { is_expected.to belong_to(:post) }
    it { is_expected.to belong_to(:user) }
    
    # make sure that value is present when votes are created
    it { is_expected.to validate_presence_of(:value) }
    
    # to test the value will become -1 (a down vote) or 1 (an up vote)
    it { is_expected.to validate_inclusion_of(:value).in_array([-1, 1]) }
    
    describe "update_post callback" do
        it "triggers update_post on save" do
            # expect 'update_post_rank'(:ipdate_post) will be called on 'vote' after vote is saved
            expect(vote).to receive(:update_post).at_least(:once)
            vote.save!
        end
        
        it "#update_post should call update_rank on post " do
            # expect the 'vote's post'(post) will receive a call to 'update_rank'(:update_rank)
            expect(post).to receive(:update_rank).at_least(:once)
            vote.save!
        end
    end

end
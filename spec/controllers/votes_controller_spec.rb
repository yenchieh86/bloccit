require 'rails_helper'
include SessionsHelper

RSpec.describe VotesController, type: :controller do
    let(:my_topic) { create(:topic) }
    let(:my_user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:user_post) { create(:post, topic: my_topic, user: other_user) }
    let(:my_vote) { Vote.create!(value: 1) }
    
    # make sure that unsigned-in user can't vote
    context "guest" do
        describe "POST up_vote" do
            it "redirects the user to the sign in view" do
                post :up_vote, post_id: user_post.id
                expect(response).to redirect_to(new_session_path)
            end
        end
        
        describe "POST down_vote" do
            it "redirects the user to the sign in view" do
                delete :down_vote, post_id: user_post.id
                expect(response).to redirect_to(new_session_path)
            end
        end
    end
    
    context "signed in user" do
        before do
            create_session(my_user)
            # by using 'request.env["HTTP_REFERER"]' to set URL to redirected back to the correct view(last page - posts or topics 'show' view)
            request.env["HTTP_REFERER"] = topic_post_path(my_topic, user_post)
        end
        
        describe "POST up_vote" do
            # make sure a up vote for a post will be count if it's the user first time voting
            it "the users first vote increases number of post votes by one" do
                votes = user_post.votes.count
                post :up_vote, post_id: user_post.id
                expect(user_post.votes.count).to eq(votes + 1)
            end
            
            # make sure a up vote for a post won't be count if it is not the user first time voting
            it "the users second vote does not increase the number of votes" do
                post :up_vote, post_id: user_post.id
                votes = user_post.votes.count
                post :up_vote, post_id: user_post.id
                expect(user_post.votes.count).to eq(votes)
            end
            
            # make sure that a up vote will invrease the number of points on the post by one
            it "increases the sum of post votes by one" do
                points = user_post.points
                post :up_vote, post_id: user_post.id
                expect(user_post.points).to eq(points + 1)
            end
            
            # make sure that user will be redirected back to the correct view(last page - posts or topics 'show' view)
            it ":back redirects to posts show page" do
                request.env["HTTP_REFERER"] = topic_post_path(my_topic, user_post)
                post :up_vote, post_id: user_post.id
                expect(response).to redirect_to([my_topic, user_post])
            end
            
            # make sure that user will be redirected back to the correct view(last page - posts or topics 'show' view)
            it ":back redirects to posts topic show" do
                request.env["HTTP_REFERER"] = topic_path(my_topic)
                post :up_vote, post_id: user_post.id
                expect(response).to redirect_to(my_topic)
            end
        end
        
        describe "POST down_vote" do
            it "the users first vote increases number of post votes by one" do
                votes = user_post.votes.count
                post :down_vote, post_id: user_post.id
                expect(user_post.votes.count).to eq(votes + 1)
            end
            
            it "the users second vote does not increase the number of votes" do
                post :down_vote, post_id: user_post.id
                votes = user_post.votes.count
                post :down_vote, post_id: user_post.id
                expect(user_post.votes.count).to eq(votes)
            end
            
            it "decreases the sum of post votes by one" do
                points = user_post.points
                post :down_vote, post_id: user_post.id
                expect(user_post.points).to eq(points - 1)
            end
            
            it ":back redirects to posts show page" do
                request.env["HTTP_REFERER"] = topic_post_path(my_topic, user_post)
                post :down_vote, post_id: user_post.id
                expect(response).to redirect_to([my_topic, user_post])
            end
            
            it ":back redirects to posts topic show" do
                request.env["HTTP_REFERER"] = topic_path(my_topic)
                post :down_vote, post_id: user_post.id
                expect(response).to redirect_to(my_topic)
            end
        end
    end
end

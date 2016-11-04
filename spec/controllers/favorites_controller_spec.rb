require 'rails_helper'
include SessionsHelper

RSpec.describe FavoritesController, type: :controller do
    
    let(:my_topic) { create(:topic) }
    let(:my_user) { create(:user) }
    let(:my_post) { create(:post, topic: my_topic, user: my_user) }
    context 'guest user' do
        describe 'POST create' do
            it 'redirects the user to the sign in view' do
                post :create, { post_id: my_post.id }
                # make sure it will redirecting guest if they attempt to favorite a post
                expect(response).to redirect_to(new_session_path)
            end
        end
        
        # make sure it will redirect guest to sign in before allowing them to unfavorite a post
        describe 'DELETE destroy' do
            it 'redirects the user to the sign in view' do
                favorite = my_user.favorites.where(post: my_post).create
                delete :destroy, { post_id: my_post.id, id: favorite.id }
                expect(response).to redirect_to(new_session_path)
            end
        end
    end
    
    context 'signed in user' do
        
        before do
            create_session(my_user)
        end
        
        describe 'POST create' do
            # make sure will redirect user back to the post's show view after they favorites a post
            # 'expect' can use in anywhere inside the 'it' block, not just the end of the 'it' block
            it 'redirects to the posts show view' do
                post :create, { post_id: my_post.id }
                expect(response).to redirect_to([my_topic, my_post])
            end
            
            it 'creates a favorite for the current user and specified post' do
                # make sure no favorites exist for the user and post
                expect(my_user.favorites.find_by_post_id(my_post.id)).to be_nil
                
                post :create, { post_id: my_post.id }
                # make sure a user will have a favorite associated with a post after they favorited a post
                expect(my_user.favorites.find_by_post_id(my_post.id)).not_to be_nil
            end
        end
        
        # make sure it will redirect user to the post's show view after user unfavorites a post
        describe 'DELETE destroy' do
            it 'redirects to the posts show view' do
                favorite = my_user.favorites.where(post: my_post).create
                delete :destroy, { post_id: my_post.id, id: favorite.id }
                 expect(response).to redirect_to([my_topic, my_post])
            end
            
            it 'destroys the favorite for the current user and post' do
                favorite = my_user.favorites.where(post: my_post).create
                # make sure the user and post has an associaed favorite that we can delete
                expect( my_user.favorites.find_by_post_id(my_post.id) ).not_to be_nil
                
                delete :destroy, { post_id: my_post.id, id: favorite.id }
                
                # make sure that the associate favorite is 'nil'
                expect( my_user.favorites.find_by_post_id(my_post.id) ).to be_nil
            end
        end
    end
end

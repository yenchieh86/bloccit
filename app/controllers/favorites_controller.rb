class FavoritesController < ApplicationController

    # will redirect guest user to sign in before allowing them to favorite a post
    before_action :require_sign_in
    
    def create
        # use 'params[:post_id]' to find the post we want to favorite
        post = Post.find(params[:post_id])
        # create a 'favorite' for the 'current user', use 'post: post' to establish associationsfor the usr, post, and favorite
        favorite = current_user.favorites.build(post: post)
        
        if favorite.save
            flash[:notice] = "Post favorited."
        else
            flash[:alert] = "Favoriting failed."
        end
        
        # redirect the user to the post's show view
        redirect_to [post.topic, post]
    end
    
    def destroy
        post = Post.find(params[:post_id])
        favorite = current_user.favorites.find(params[:id])
        
        if favorite.destroy
            flash[:notice] = "Post unfavorited."
        else
            flash[:alert] = "Unfavoriting failed."
        end
        
        redirect_to [post.topic, post]
    end
end

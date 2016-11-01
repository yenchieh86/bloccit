class CommentsController < ApplicationController
    
    # use 'require_sign_in' to ensure that only permitted user can use create comment
    before_action :require_sign_in
    
    # add 'authorize_user' filter to ensure that unauthorized user are not permitted to delete comments
    before_action :authorize_user, only: [:destroy]
    
    def create
        # use 'post_id' to find the corrext post
        @post = Post.find(params[:post_id])
        # user 'comment.params' to create new comment
        comment = @post.comments.new(comment_params)
        # assign the comment's user to 'current_user', and 'current_user' will returns the signed-in user instance
        comment.user = current_user
        
        if comment.save
            flash[:notice] = "Comment saved successfully"
            # redirect the user to the post 'show'view'
            redirect_to [@post.topic, @post]
        else
            flash[:alert] = "Comment failed to save"
            redirect_to [@post.topic, @post]
        end
    end
    
    def destroy
        @post = Post.find(params[:post_id])
        comment = @post.comments.find(params[:id])
        
        if comment.destroy
            flash[:notice] = "Comment was deleted"
            redirect_to [@post.topic, @post]
        else
            flash[:alert] = "Comment couldn't be deleted. Try again."
            redirect_to[@post.topic, @post]
        end
    end
    
    private
    
    # define a private method 'comment_params'
    # it will white lists the parameters we need to create comments.
    def comment_params
        params.require(:comment).permit(:body)
    end
    
    # define the 'authorize_user' method which allows the comment owner or an admin user to delete the comment
    # then redirect unauthorized users to the post 'show' view
    def authorize_user
        comment = Comment.find(params[:id])
        unless current_user == comment.user || current_user.admin?
            flash[:alert] = "You don't have permission to delete a comment."
            redirect_to [comment.post.topic, comment.post]
        end
    end
end
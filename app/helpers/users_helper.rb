module UsersHelper
    def user_posts_any?(user)
        user.posts.count > 0
    end
    
    def user_comment_any?(user)
        user.comments.count > 0
    end
end

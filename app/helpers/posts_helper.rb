module PostsHelper
    
    # use to check if there is a sign-in 'current_user'
    def user_is_authorized_for_post?(post)
        current_user && current_user.role != "moderator" && (current_user == post.user || current_user.admin?)
    end
    
    def user_is_authorized_for_topics_moderator?(post)
        current_user && (current_user == post.user || current_user.admin? || current_user.moderator?)
    end
end

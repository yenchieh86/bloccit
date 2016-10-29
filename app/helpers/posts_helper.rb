module PostsHelper
    
    # use to check if there is a sign-in 'current_user'
    def user_is_authorized_for_post?(post)
        current_user && (current_user == post.user || current_user.admin?)
    end
    
    def user_is_authorized_for_post_create_edit?(post)
        current_user && (current_user == post.user || current_user.admin? || current_user.moderator?)
    end
    
    def cant_be_moderator
        if current_user.moderator?
            return false
        end
    end
end

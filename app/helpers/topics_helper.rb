module TopicsHelper
    
    # this method is available to be use in all'topic' file
    def user_is_authorized_for_topics?
        current_user && current_user.admin?
    end
   
    def user_is_authorized_for_topics_higher_than_moderator?
        current_user && (current_user.admin? || current_user.moderator?)
    end
end

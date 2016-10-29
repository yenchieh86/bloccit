module TopicsHelper
    
    # this method is available to be use in all'topic' file
   def user_is_authorized_for_topics?
        current_user && current_user.admin?
   end
end

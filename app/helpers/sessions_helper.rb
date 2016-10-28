# need to add this file into 'application_controller.rb' so it can be use in other file
module SessionsHelper
    
    # it gives 'user.id' to 'user_id' on the 'session object', which is unique for each user
    # 'session' is an 'object' tha tprovide by Rails, use to track the state of a particular user
    # there's a 1-on-1 relationship between 'session object' and 'user id' (one session object only has one user id, and user id only has one session object)
    def create_session(user)
        session[:user_id] = user.id
    end
    
    # to clear the user id on the session object by setting session's 'user_id' to 'nil'
    # it will effectively destroys the user session
    # we can't track the 'user_id' anymore because it's 'nil' now
    def destroy_session(user)
        session[:user_id] = nil
    end
    
    # it will finds the signed-in user by taking the 'user_id' from session, and searching the database for the user in question
    # it will return the current user of the application
    # the related session object will be destroyed when the user closes Bloccit. 
    # it pack the pattern of finding the current user that we need to use through whole Bloccit
    # 
    def current_user
        User.find_by(id: session[:user_id])
    end
end

class SessionsController < ApplicationController
    
    def new
        
    end
    
    def create
        # use to search database for a user with the specified email in 'params' hash
        # use 'downcase' to normalize the email address since the addresses stored in the database are stored as lowercase strings
        user = User.find_by(email: params[:session][:email].downcase)
        
        # 'create_session(user)' method is in 'app/helpers/sessions_helper.rb'
        # make sure 'user' is not 'nil', and the password in 'params' hash matches it
        # if user is nil, it will go to 'else' block, it's help to prevent a null pointer exception
        # will call 'create_session' function if the 'user' seuccessed
        if user && user.authenticate(params[:session][:password])
            create_session(user)
            flash[:notice] = "Welcome, #{user.name}!"
            redirect_to root_path
        else
            flash.now[:alert] = ' Invalid email/password combination'
            render :new
        end
    end
    
    # it will delete a user's 'session'
    # it will logs the user out by calling 'destroy_session(current_user)', flash a notice, and redirects the user to 'root-path'
    # 'destroy_session(current_user)' method is in 'app/helpers/sessions_helper.rb'

    def destroy
        destroy_session(current_user)
        flash[:notice] = "You've been signed out, come back soon!"
        redirect_to root_path
    end
    
end

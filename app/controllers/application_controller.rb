class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # to include 'app/helpers/sessions_helpers_rb' so it can be use in other files
  include SessionsHelper
  
  private
  # use to redirect un-sign-in user
  # define in this file so this method can be use in every file
    def require_sign_in
      unless current_user
        flash[:alert] = "You must be logged in to do that"
        # redirect un-sign-in user to the sign-in page
        redirect_to new_session_path
      end
    end
end

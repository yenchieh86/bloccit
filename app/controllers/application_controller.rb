class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # to include 'app/helpers/sessions_helpers_rb' so it can be use in other files
  include SessionsHelper
  
end

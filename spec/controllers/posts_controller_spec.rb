require 'rails_helper'

# this file is test for 'PostsController'
# 'type: :controller' tells RSpec to treat this file as a test for controller
# a test for controller can allow us to simulate controller action , such as HTTP request
RSpec.describe PostsController, type: :controller do

  # create a post, and assign it to 'my_post' by using 'let'
  # use 'RandomData' to give 'my_post' a random title and boy
  let(:my_post) {Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph)}
  
  describe "GET #index" do
    it "returns http success" do
      # the test use 'get'(GET) on the ':index'(index view), and expect the response to be successful
      # 'have_http_status' is an RSpec matcher, it encapsulate the logic to check is the response success or fail
      # 'have_http_status(:success)' checks for response code of 200 for the standard HTTP response code for success
      get :index
      expect(response).to have_http_status(:success)
    end
    
    it "assigns [my_post] to @posts" do
      get :index
      # expect index of the poet (my_post) to return an array of one element
      # 'assigns' is a method form 'ActionController::TestCase'
      # 'assigns' let the test can access to "instance variables which were assigned in the action that are available for the view"
      expect(assigns(:posts)).to eq([my_post])
    end
  end

  # save below tests for later
  #describe "GET #show" do
    #it "returns http success" do
      #get :show
      #expect(response).to have_http_status(:success)
    #end
  #end

  #describe "GET #new" do
    #it "returns http success" do
      #get :new
      #expect(response).to have_http_status(:success)
    #end
  #end

  #describe "GET #edit" do
    #it "returns http success" do
      #get :edit
      #expect(response).to have_http_status(:success)
    #end
  #end

end

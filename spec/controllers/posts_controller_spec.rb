require 'rails_helper'

# this file is test for 'PostsController'
# 'type: :controller' tells RSpec to treat this file as a test for controller
# a test for controller can allow us to simulate controller action , such as HTTP request
RSpec.describe PostsController, type: :controller do

  # create a post, and assign it to 'my_post' by using 'let'
  # use 'RandomData' to give 'my_post' a random title and boy
  let(:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }
  
  describe "GET index" do
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

  
  describe "GET show" do
    it "returns http success" do
      # pass '[id: my_post.id}' as parameter to 'show'(the params hash)
      # 'params hash' contains all parameters passed to the application's controller(application_controller.rb)
      get :show, {id: my_post.id}
      expect(response).to have_http_status(:success)
    end
    
    it "renders the #show view" do
      # use 'render_template matcher' to expect the 'response' to retunr the 'show view'
      get :show, {id: my_post.id}
      expect(response).to render_template :show
    end
    
    it "assigns my_post to @post" do
      # use ':show' on '{id: my_post.id}'
      get :show, {id: my_post.id}
      # expect ':post'(the post) to equal 'my_post'(the post we ask for)
      expect(assigns(:post)).to eq(my_post)
    end
  end

  # describe 'new'
  # when 'new' is invoked, a new and unsaved 'Post object' is created
  # a 'get' request shouldn't generate new data, so ':new' doesn't create data
  # use 'get :new' to access 'PostsController#new'
  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    
    # use 'render_tamplate' to make sure that 'response from PostsController#new' will give the posts ':new'(new view)
    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end
    
    # expect '@post's instance variable' to be initialized by 'get :new'
    # use 'assigns' to access '@post variable', and assign it to ':post'
    it "instantiates @post" do
      get :new
      expect(assigns(:post)).not_to be_nil
    end
  end
  
  # describe 'create'
  # when 'create' is invoked, the newly created object will be put into the database and saved
  # a 'post' request are used for create new date, so use 'create' to create the fields in a post
  describe "POST create" do
    # expect 'the count of Post database's instances(rows in the posts table)' will increase by 1
    # use 'post :create' to access 'PostsController#create'
    it "increases the number of Post by 1" do
      expect{post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post, :count).by(1)
    end
    
    # expect 'the newly created post' to be assigned to '@post'(Post.last)
    # use 'assigns' to access '@post variable', and assign it to ':post'
    # assign the newly created post to @post by using ':create' and 'post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}'
    it "assigns the new post to @post" do
      post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(assigns(:post)).to eq Post.last
    end
    
    # use 'redirect_to Post.last' to check 'response' will redirect to the newly created post 
    it "redirects to the new post" do
      post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(response).to redirect_to Post.last
    end
  end

  #describe "GET #edit" do
    #it "returns http success" do
      #get :edit
      #expect(response).to have_http_status(:success)
    #end
  #end

end

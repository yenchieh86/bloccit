require 'rails_helper'

# this file is test for 'PostsController'
# 'type: :controller' tells RSpec to treat this file as a test for controller
# a test for controller can allow us to simulate controller action , such as HTTP request
RSpec.describe PostsController, type: :controller do

  # create 'my_topic' use to be posts' parent, because we want posts nest under topic
  let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  
  # update 'my_post' for letting it belong to 'my_topic'
  let(:my_post) {my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

  
  describe "GET show" do
    it "returns http success" do
      # update 'get :show' to request for the id of the parent topic
      get :show, topic_id: my_topic.id, id: my_post.id
      expect(response).to have_http_status(:success)
    end
    
    it "renders the #show view" do
      # use 'render_template matcher' to expect the 'response' to retunr the 'show view'
      get :show, topic_id: my_topic.id, id: my_post.id
      expect(response).to render_template :show
    end
    
    it "assigns my_post to @post" do
      # use ':show' on '{id: my_post.id}'
      get :show, topic_id: my_topic.id, id: my_post.id
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
      # update the 'get :new' for request to include the id of the parent topic
      get :new, topic_id: my_topic.id
      expect(response).to have_http_status(:success)
    end
    
    # use 'render_tamplate' to make sure that 'response from PostsController#new' will give the posts ':new'(new view)
    it "renders the #new view" do
      get :new, topic_id: my_topic.id
      expect(response).to render_template :new
    end
    
    # expect '@post's instance variable' to be initialized by 'get :new'
    # use 'assigns' to access '@post variable', and assign it to ':post'
    it "instantiates @post" do
      get :new, topic_id: my_topic.id
      expect(assigns(:post)).not_to be_nil
    end
  end
  
  # describe 'create'
  # when 'create' is invoked, the newly created object will be put into the database and saved
  # a 'post' request are used for create new date, so use 'create' to create the fields in a post
  describe "POST create" do
    # expect 'the count of Post database's instances(rows in the posts table)' will increase by 1
    # use 'post :create' to access 'PostsController#create'
    # update the 'post :create ' for request to include the id of the parent topic
    it "increases the number of Post by 1" do
      expect{post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
    end
    
    # expect 'the newly created post' to be assigned to '@post'(Post.last)
    # use 'assigns' to access '@post variable', and assign it to ':post'
    it "assigns the new post to @post" do
      post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(assigns(:post)).to eq Post.last
    end
    
    # use 'redirect_to Post.last' to check 'response' will redirect to the newly created post 
    it "redirects to the new post" do
      post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      # change from redirecting to 'Post.last' to '[my_topic, Post.last]'
      expect(response).to redirect_to [my_topic, Post.last]
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, topic_id: my_topic.id, id: my_post.id
      expect(response).to have_http_status(:success)
    end
    
    it "renders the #edit view" do
      get :edit, topic_id: my_topic.id, id: my_post.id
      # expect the edit view to render when a post is edited
      expect(response).to render_template :edit
    end
    
    # make sure the update of the @post is correct
    it "assigns post to be updated to @post" do
      get :edit, topic_id: my_topic.id, id: my_post.id
      
      post_instance = assigns(:post)
      
      expect(post_instance.id).to eq my_post.id
      expect(post_instance.title).to eq my_post.title
      expect(post_instance.body).to eq my_post.body
    end
  end
  
  describe "PUT update" do
    it "updates post with expected attributes" do 
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      
      put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
      
      # check title and body of the @post has been update, also check the id of @post was not changed
      updated_post = assigns(:post)
      expect(updated_post.id).to eq my_post.id
      expect(updated_post.title).to eq new_title
      expect(updated_post.body).to eq new_body
    end
    
    it "redirects to the updated post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      
      # check did it redirected to the posts 'show view' after update
      put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
      expect(response).to redirect_to [my_topic, my_post]
    end
  end
  
  describe "DELETE destroy" do
    it "deletes the post" do
      delete :destroy, topic_id: my_topic.id, id: my_post.id
      # use '.where' to search a post which has same id as 'my_post.id'
      # 'Post.where({id: my_post.id}).size' will return a size(.size) of array 'Post.where({id: my_post.id})' to count
      # count should equal 0, because there's no match after destory was called and deleted the post
      count = Post.where({id: my_post.id}).size
      expect(count).to eq 0
    end
    
    it "redirects to topic show" do
      delete :destroy, topic_id: my_topic.id, id: my_post.id
      # make sure it will redirected to the posts index view after deleted a post
      expect(response).to redirect_to my_topic
    end
  end

end

# use 'rails generate controller Posts index show new edit' to create this file (Post controller)
# then change the code in 'config/routes.rb'

class PostsController < ApplicationController
  def index
    # declare '@post'(an instance variable)
    # use 'Post.all' to return a collection of Post objects, and to assign those objects to '@post'
    # '.all' method is in 'ActiveRecord'
    @posts = Post.all
   
  end
  
  def show
    # use '.find' to find post that match the ':id' we passed in 'params', and assign the post to @post
    # 'show' differen't than 'index' is 'show' only return a single post, 'index' return a collection of posts
    @post = Post.find(params[:id])
  end

  def new
    # create an instance variable '@post'
    # 'Post.new' will return an empty post
    # assign the new empty post(Post.new) to the instance variable(@post)
    @post = Post.new
  end
  
  def create
    # use 'Post.new' to create a new instance of Post
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]
    
    # check if the new instance of Post has been successful saved
    if @post.save
      # use 'flash[:notice]' to display a message
      # use 'flash[:notice]'(flash hash) to pass in a temporrary values for actions, and the valuse will be deleted after action
      flash[:notice] = "Post was saved."
      # redirect the user to the view of the route, which generated by @post
      redirect_to @post
    else
      # will display an error message
      flash.new[:alert] = "There was an error saving the post. Please try again."
      # will show ':new'(the new view) again
      render :new
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end  
  
  def update 
    @post = Post.find(params[:id])
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]
    
    if @post.save
      flash[:notice] = "Post was updated."
      redirect_to @post
    else
      flash.now[:alert] = "There was an error, saving the post. Please try again."
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to posts_path
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end
end

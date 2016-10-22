# use 'rails generate controller Posts index show new edit' to create this file (Post controller)
# then change the code in 'config/routes.rb'

class PostsController < ApplicationController
  def index
    # declare '@post'(an instance variable)
    # use 'Post.all' to return a collection of Post objects, and to assign those objects to '@post'
    # '.all' method is in 'ActiveRecord'
    @posts = Post.all
    @posts.each_with_index { |post, index| post.title = 'SPAM' unless index % 5 != 0}
  end

  def show
  end

  def new
  end

  def edit
  end
end

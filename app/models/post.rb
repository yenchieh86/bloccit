# use 'rails generate model Post title:string body:text' to create this model
# this command will create several files: 'post.rb', 'post_spec.rb', '20150606010447_create_posts.rb'
# 'post.rb' : the Post model. It will handle the logic and define the behavior for posts
# 'post_spec.rb' : the RSpec Test for the Post class
# '20150606010447_create_posts.rb' : the database migration file. It define how to handle the database by the given model. 

# this model takes two attribute: 'title' and 'body'
# because we want title's value to be short. so we set it as a string data type
# because we hope body's value can include verbose information, so we sent it as a text data type, so user can type in hundreds of characters

# can use 'cat app/models/post.rb' to review this file in the command line

class Post < ActiveRecord::Base
    
    belongs_to :topic
    
    # set this post class to relate to the comment class
    # by using 'has_many' method can allow a post instance to have many comments, relate to many comment class, also provide method for us to access to those comment
    # use 'dependent: :destroy' to make sure that we delete the post's comment too
    # then use 'link_to' add a link to delete posts on the show view
    has_many :comments, dependent: :destroy
    
    # use to set that 'Post' the data of 'title', 'body', 'topic' is exist
    # to set up the minimum length of 'title' and 'body'
    validates :title, length: { minimum: 5 }, presence: true
    validates :body, length: { minimum: 20 }, presence: true
    validates :topic, presence: true
    
end

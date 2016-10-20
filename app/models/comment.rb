# use 'rails generate model Comment body:text post:references' to create this file
# this is a 'Comment model', it need one attribute 'body', and a reference to 'Post'

# can use 'cat app/models/comment.rb' to review this file on command line
class Comment < ActiveRecord::Base
    
    # another way to say this is 'a post has many comments'
    # set this comment class to relates to the post class
    belongs_to :post
end

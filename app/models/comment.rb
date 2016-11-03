# use 'rails generate model Comment body:text post:references' to create this file
# this is a 'Comment model', it need one attribute 'body', and a reference to 'Post'

# can use 'cat app/models/comment.rb' to review this file on command line
class Comment < ActiveRecord::Base
    
    # another way to say this is 'a post has many comments'
    # set this comment class to relates to the post class
    belongs_to :post
    belongs_to :user
    
    validates :body, length: { minimum: 5 }, presence: true
    validates :user, presence: true
    
    # app will call ':send_favorite_emails' after create a comment for post
    # it will find 'favorites' associated with its comment's post, and loop over them. It will create and send email for each favorite
    after_create :send_favorite_emails
    
    def send_favorite_emails
        post.favorites.each do |favorite|
            FavoriteMailer.new_comment(favorite.user, post, self).deliver_now
        end
    end
end

class FavoriteMailer < ApplicationMailer
    # set the default 'from' for all emails sent from 'FavoriteMailer'
    default from: "yenchieh86@hotmail.com"
    
    # will call this method to send an email to user, notify them that someone has left a comment on one of their favorited posts
    def new_comment(user, post, comment)
        # ser 3 different 'headers' to enable 'conversation threading' in different email clients
        headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
        headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
        headers["References"] = "<post/#{post.id}@your-app-name.example>"
        
        @user = user
        @post = post
        @comment = comment
        
        # 'mail' method takes a 'hash' of mail relevant information - the subject, the 'to:' address, the 'from', and any 'cc' or 'bcc' information. And will prepares the email to be sent
        mail(to: user.email, subject: "New comment on #{post.title}")
    end
    
    def new_post(post)

        headers["Message-ID"] = "<posts/#{post.id}@your-app-name.example>"
        headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
        headers["References"] = "<post/#{post.id}@your-app-name.example>"
       
        @post = post
        
        mail(to: post.user.email, subject: "New post on #{post.title}")
    end
end

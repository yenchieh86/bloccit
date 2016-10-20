require 'rails_helper'

RSpec.describe Post, type: :model do
  
  # use 'let' method to create a new instance of the Post class
  # use 'let' to defines a method "post", also calculate and store the return value when we first time call it in spec
  let(:post) { Post.create!(title: "New Post Title", body: "New Post Body") }
  
  # make sure that 'post' has two attribute: 'title' and 'body'
  describe "attributes" do
      it "has title and body attributes" do 
          expect(post).to have_attributes(title: "New Post Title", body: "New Post Body")
      end
  end
end

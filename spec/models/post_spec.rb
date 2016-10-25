require 'rails_helper'

RSpec.describe Post, type: :model do
  
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
  
  # create a parent topic for 'post'
  let(:topic) { Topic.create!(name: name, description: description) }
  
  # associate 'post' with 'topic' through 'topic.posts.create!'
  # it's a chained method call for creates a post for a given topic
  let(:post) { topic.posts.create!(title: title, body: body) }
  
  it{ is_expected.to belong_to(:topic) }

  # make sure that 'post' has two attribute: 'title' and 'body'
  describe "attributes" do
      it "has title and body attributes" do 
          expect(post).to have_attributes(title: title, body: body)
      end
  end
end

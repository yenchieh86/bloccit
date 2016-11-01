require 'rails_helper'

RSpec.describe Post, type: :model do
  
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
  
  # create a parent topic for 'post'
  let(:topic) { Topic.create!(name: name, description: description) }
  
  # create a user to associate with a test post
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  
  # associate 'user' with 'post' when we create the test post
  # associate 'post' with 'topic' through 'topic.posts.create!'
  # it's a chained method call for creates a post for a given topic
  let(:post) { topic.posts.create!(title: title, body: body, user: user) }
  
  it { is_expected.to have_many(:comments) }
  it { is_expected.to belong_to(:topic) }
  it { is_expected.to belong_to(:user) }
  
  # use to make sure that 'Post' the data of 'title', 'body', 'topic', 'user' is exist
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:topic) }
  it { is_expected.to validate_presence_of(:user) }

  # to test the minimum length of 'title' and 'body'
  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(20) }

  # make sure that 'post' has two attribute: 'title' and 'body'
  describe "attributes" do
      it "has a title, body, and user attribute" do
          expect(post).to have_attributes(title: title, body: body, user: user)
      end
  end
end

require 'rails_helper'

RSpec.describe Question, type: :model do
    # use 'let' method to create a new instance of the Post class
    # use 'let' to defines a method "post", also calculate and store the return value when we first time call it in spec
    let(:question) { Question.create!(title: "New Post Title", body: "New Post Body", resolved: false)}
        
    describe "attributes" do
        it "has title, body and resolved attributes" do
            expect(question).to have_attributes(title: "New Post Title", body: "New Post Body", resolved: false)
        end
    end
end

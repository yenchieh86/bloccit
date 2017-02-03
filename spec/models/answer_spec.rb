require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:question) { Question.create!(title: "New Post Title", body: "New Post Body", resolved: false)}
  let(:answer) {Answer.create!(body: "New Post Body")}

  describe "attribues" do
    it "has a body attributes" do
      expect(answer).to have_attributes(body: "New Post Body")
    end
  end
end
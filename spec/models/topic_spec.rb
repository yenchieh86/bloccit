require 'rails_helper'

RSpec.describe Topic, type: :model do
    let(:name) { RandomData.random_sentence }
    let(:description) {RandomData.random_paragraph }
    let(:public) { true }
    let(:topic) { Topic.create!(name: name, description: description)}
    
    # use the methods provided by Shoulda     
    it { is_expected.to have_many(:posts) }
    
    # to confirm that a topic respond to the appropriate attributes
    describe "attributes" do
        it "has name, description, and public attributes" do
            expect(topic).to have_attributes(name: name, description: description, public: public)
        end
        
        # to confirm that the 'public' attribute is set to 'true' by default
        it "is public by default" do
            expect(topic.public).to be(true)
        end
    end
end

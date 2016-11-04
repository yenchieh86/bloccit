require 'rails_helper'

RSpec.describe Topic, type: :model do
    let(:public) { true }
    let(:topic) { create(:topic) }
    
    # use the methods provided by Shoulda     
    it { is_expected.to have_many(:posts) }
    it { is_expected.to have_many(:sponsoredposts) }
    
    
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    

    it { is_expected.to validate_length_of(:name).is_at_least(5) }
    it { is_expected.to validate_length_of(:description).is_at_least(15) }
    # to confirm that a topic respond to the appropriate attributes
    describe "attributes" do
        it "has name, description, and public attributes" do
            expect(topic).to have_attributes(name: topic.name, description: topic.description)
        end
        
        # to confirm that the 'public' attribute is set to 'true' by default
        it "is public by default" do
            expect(topic.public).to be(true)
        end
    end
end

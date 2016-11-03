require 'rails_helper'

RSpec.describe User, type: :model do
    let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "password") }
    
    
    it { is_expected.to have_many(:posts) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:favorites) }
    
    # to test the association between user and vote
    it { is_expected.to have_many(:votes) }
    
    # use to tests field validation and attributes
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(1) }
  
    # use to tests field validation and attributes
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_length_of(:email).is_at_least(3) }
    it { is_expected.to allow_value("user@bloccit.com").for(:email) }
   
    # use to tests field validation and attributes
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  
    describe "attributes" do
        
        it "should have name and email attributes" do
            expect(user).to have_attributes(name: "Bloccit User", email: "user@bloccit.com")
        end
        
        it "should upcase the first letter" do
            user.name = "yen chen"
            user.save
            expect(user.name).to eq "Yen Chen"
        end
        
        # expect 'user' will respond to 'role'
        it "responds to role" do
            expect(user).to respond_to(:role)
        end
        
        # will return 'true / false' to check that is the user a admin or not
        # will implement is by using the 'ActiveRecord::Enum' class
        it "responds to admin" do
            expect(user).to respond_to(:admin?)
        end
        
        # will return 'true / false' to check that is the user a member or not
        it "responds to member?" do
            expect(user).to respond_to(:member?)
        end
    end
    
    describe "roles" do
        
        # expect user will be assigned as a member by default
        it "is member by default" do
            expect(user.role).to eql("member")
        end
        
        # test 'member' users with separate contexts
        context "member user" do
            it "returns true for #member?" do
                expect(user.member?).to be_truthy
            end
            
            it "returns false for #admin?" do
                expect(user.admin?).to be_falsey
            end
        end
        
        # test 'admin' users with separate contexts
        context "admin user" do
            
            before do
                user.admin!
            end
            
            it "returns false for #member?" do
                expect(user.member?).to be_falsey
            end
            
            it "returns true for #admin?" do
            expect(user.admin?).to be_truthy
            end
        end
    end
    
    # use to test adding an invalid user
    # this called 'true negative', to test for a value that shouldn't exist
    describe "invalid user" do 
        let(:user_with_invalid_name) { User.new(name: "", email: "user@bloccit.com") }
        let(:user_with_invalid_email) { User.new(name: "Bloccit User", email: "") }
        
        it "should be an invalid user due to blank name" do
            expect(user_with_invalid_name).to_not be_valid
        end
        
        it "should be an invalid user due to blank email" do
            expect(user_with_invalid_email).to_not be_valid
        end
    end
    
    describe "#favorite_for(post)" do
        before do
            topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
            @post = topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)
        end
        
        it "returns 'nil' if the user has not favorited the post" do
            # make sure that 'favorite_for(@post)' will return 'nil' if the user has not favorited any post from @post
            expect(user.favorite_for(@post)).to be_nil
        end
        
        it "returns the appropriate favorite if it exists" do 
            # create a favorite for 'user' and '@post'
            favorite = user.favorites.where(post: @post).create
            # make sure that 'favorite_for' will return the favorite we just created
            expect(user.favorite_for(@post)).to eq(favorite)
        end
    end
end
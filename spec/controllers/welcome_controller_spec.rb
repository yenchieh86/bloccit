# this RSpec test is for testing 'WelcomeController'

require 'rails_helper'

# describe the subject of the spec
RSpec.describe WelcomeController, type: :controller do
    
    describe "GET index" do
        it "renders the index template" do
            # use get to call the index method from WelcomeController
            get :index
            # expect the 'response' from controller is given the 'index' template
            expect(response).to render_template("index")
        end
    end
    
    describe "GET about" do
        it "renders the about template" do
            get :about
            expect(response).to render_template("about")
        end
    end

end

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    
    # create a hash 'new_user_attributes'
    let(:new_user_attributes) do 
        {
            name: "Bloc Head",
            email: "blochead@bloc.io",
            password: "blochead",
            password_confirmation: "blochead"
        }
    end
    
    # to test 'new' action for HTTP success when issuing a GET
    describe "GET new" do
        it "returns http success" do
            get :new
            expect(response).to have_http_status(:success)
        end
        
        it "instantiates a new user" do
            get :new
            expect(assigns(:user)).to_not be_nil
        end
    end
    
    describe "POST create" do
        # make sure 'create' action for HTTP will success when issuing a 'POST' with 'new_user_attributes' hash as param
        it "returns an http redirect" do
            post :create, user: new_user_attributes
            expect(response).to have_http_status(:redirect)
        end
        
        # maker sure the database count on the users table will increases by one when we issue a 'POST' to 'create'
        it "creates a new user" do
            expect{ post :create, user: new_user_attributes }.to change(User, :count).by(1)
        end
        
        # test that we set 'user.name' properly when creating a user
        it "sets user name properly" do
            post :create, user: new_user_attributes
            expect(assigns(:user).name).to eq new_user_attributes[:name]
        end
        
        # test that we set 'user.email' properly when creating a user
        it "sets user email properly" do
            post :create, user: new_user_attributes
            expect(assigns(:user).email).to eq new_user_attributes[:email]
        end
        
        # test that we set 'user.password' properly when creating a user.
        it "sets user password properly" do
            post :create, user: new_user_attributes
            expect(assigns(:user).password).to eq new_user_attributes[:password]
        end
        
        # test that we set 'user.password_confirmation' properly when creating a user.
        it "sets user password_confirmation properly" do
            post :create, user: new_user_attributes
            expect(assigns(:user).password_confirmation).to eq new_user_attributes[:password_confirmation]
        end
        
        it "logs the user in after sign up" do
            post :create, user: new_user_attributes
            expect(session[:user_id]).to eq assigns(:user).id
        end
    end
    
    describe "not signed in" do
        
        let(:factory_user) { create(:user) }
        
        before do
            post :create, user: new_user_attributes
        end
        
        it "returns http success" do
            get :show, {id: factory_user.id}
            expect(response).to have_http_status(:success)
        end
        
        it "renders the #show view" do
            get :show, {id: factory_user.id}
            expect(response).to render_template :show
        end
        
        it "assigns factory_user to @user" do
            get :show, {id: factory_user.id}
            expect(assigns(:user)).to eq(factory_user)
        end
    end
end

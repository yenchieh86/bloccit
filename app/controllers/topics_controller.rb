class TopicsController < ApplicationController
    
    # use the 'before_action' filter and the 'require_sign_in' method to redirect 'guest' who try to access controller action other than 'index' and 'show'
    # 'before_action' filter and the 'require_sign_in' method are from 'ApplicationController'
    before_action :require_sign_in, except: [:index, :show]
    # user 'before_action' filter to check the role of sign-in user
    # if the sign-in user is not admin, then we will redirect them to the topic 'index' view
    before_action :authorize_user, except: [:index, :show]
    
    
    def index
        @topics = Topic.all
    end
    
    def show
        @topic = Topic.find(params[:id])
    end
    
    def new
        @topic = Topic.new
    end
    
    def create
        # replace @topic = Topic.new
        #         @topic.name = params[:topic][:name]
        #         @topic.description = params[:topic][:description]
        #         @topic.public = params[:topic][:public]
        @topic = Topic.new(topic_params)
        
        if @topic.save
            redirect_to @topic, notice: "Topic was saved successfully."
        else
            flash.now[:alert] = "Error creating topic. Please try again."
            render :new
        end
    end
    
    def edit
        @topic = Topic.find(params[:id])
    end
    
    def update
        @topic = Topic.find(params[:id])
        
        # replace @topic.name = params[:topic][:name]
        #         @topic.description = params[:topic][:description]
        #         @topic.public = params[:topic][:public]
        @topic.assign_attributes(topic_params)
        
        if @topic.save
            flash[:notice] = "Topic was updated."
            redirect_to @topic
        else
            flash.now[:alert] = "Error saving topic. Please try again."
            render :edit
        end
    end
    
    def destroy
        @topic = Topic.find(params[:id])
        
        if @topic.destroy
            flash[:notice] = "\"#{@topic.name}\"was deleted successfully."
            redirect_to action: :index
        else
            flash.now[:alert] = "There was an error deleting the topic."
            render :show
        end
    end
    
    private
    
    def topic_params
        params.require(:topic).permit(:name, :description, :public)
    end
    
    # define 'authorize_user'
    # will show alert if user is not a admin
    def authorize_user
        unless current_user.admin? || current_user.moderator?
            flash[:alert] = "You must be an admin to do that."
            redirect_to topics_path
        end
    end
    
    
end
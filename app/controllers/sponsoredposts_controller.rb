class SponsoredpostsController < ApplicationController
  def show
    @sponsoredpost = Sponsoredpost.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @sponsoredpost = Sponsoredpost.new
  end

  def edit
    @sponsoredpost = Sponsoredpost.find(params[:id])
  end
  
  def create
    @sponsoredpost = Sponsoredpost.new
    @sponsoredpost.title = params[:sponsoredpost][:title]
    @sponsoredpost.body = params[:sponsoredpost][:body]
    @sponsoredpost.price = params[:sponsoredpost][:price]
    @topic = Topic.find(params[:topic_id])
    
    @sponsoredpost.topic = @topic
    
    if @sponsoredpost.save
      flash[:notice] = "Sponsoredpost was saved."
      redirect_to [@topic, @sponsoredpost]
    else
      flash.new[:alert] = "There was an error saving the sponsoredpost. Please try again."
      render :new
    end
  end
  
  def update
    @sponsoredpost = Sponsoredpost.find(params[:id])
    @sponsoredpost.title = params[:sponsoredpost][:title]
    @sponsoredpost.body = params[:sponsoredpost][:body]
    @sponsoredpost.price = params[:sponsoredpost][:price]
    
    if @sponsoredpost.save
      flash[:notice] = "Sponsoredpost was saved."
      redirect_to [@sponsoredpost.topic, @sponsoredpost]
    else
      flash.now[:alert] = "There was an error deleting the sponsoredpost."
      render :edit
    end
  end
  
  def destroy
    @sponsoredpost = Sponsoredpost.find(params[:id])
    
    if @sponsoredpost.destroy
      flash[:notice] = "\"#{@sponsoredpost.title}\" was deleted successfully."
      redirect_to @sponsoredpost.topic
    else
      flash.now[:alert] = "There was an error deleting the sponsoredpost."
      render :show
    end
    
  end
end
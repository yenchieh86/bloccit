class AdvertisementsController < ApplicationController
  def index
    @advertisements = Advertisement.all
  end

  def show
    @advertisement = Advertisement.find(params[:id])
  end

  def new
    @advertisement = Advertisement.new
  end

  def create
    @advertisement = Advertisement.new(advertisements_params)

    if @advertisement.save 
      flash[:notice] = "advertisement was saved."
      redirect_to @advertisement
    else
      flash.new[:alert] = "There was an erorr, please try again."
      render :new
    end
  end
  
  private
  
  def advertisements_params
    params.require(:advertisement).permit(:title, :body, :price)
  end
end

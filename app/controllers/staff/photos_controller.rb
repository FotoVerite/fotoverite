class Staff::PhotosController < StaffController

  def index
    @portfolio = Portfolio.find(params[:portfolio_id])
    @photos = @portfolio.photos.order(:id).paginate(:page => params[:page])
    @count = @portfolio.photos.visible.count
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    @photo.attributes = photo_params
    respond_to do |format|
      format.html do
        if @photo.save
          flash[:notice] = "The photo has been updated"
          redirect_to staff_portfolio_photos_path
        else
          render('edit')
        end
      end
      format.json do
        if @photo.save
          render :json => {:status => 200}
        else
          render :status => 404
        end
      end
    end
  end

  private

  def photo_params
    params.require(:photo).permit(
      "title",
      "visible"
    )
  end

end

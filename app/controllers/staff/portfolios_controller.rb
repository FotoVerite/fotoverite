class Staff::PortfoliosController < StaffController

  def index
    @portfolios = Portfolio.paginate(:page => params[:page])
    @count = Portfolio.visible.count
  end

  def edit
    @portfolio = Portfolio.find(params[:id])
  end

  def update
    @portfolio = Portfolio.find(params[:id])
    @portfolio.attributes = portfolio_params
    respond_to do |format|
      format.html do
        if @portfolio.save
          flash[:notice] = "The portfolio has been updated"
          redirect_to staff_portfolios_path
        else
          render('edit')
        end
      end
      format.json do
        if @portfolio.save
          render :json => {:status => 200}
        else
          render :status => 404
        end
      end
    end
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(
      "title",
      "visible"
    )
  end

end

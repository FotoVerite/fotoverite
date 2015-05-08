class PortfoliosController < ApplicationController

  def index
    @portfolios = Portfolio.visible.paginate(page: params[:page], per_page: 50).order('created_at ASC')
  end

  def show
    @portfolio = Portfolio.visible.find(params[:id])
    @photos = @portfolio.photos.visible.paginate(page: params[:page], per_page: 50).order('created_at ASC')
  end

end

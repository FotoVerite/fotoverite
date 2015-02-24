class StaticPagesController < ApplicationController

  before_filter :ensure_valid, :only => [:show]

  def show
    @portfolios = Portfolio.paginate(page: params[:page], per_page: 15).order('created_at DESC')

    if current_page == 'home'
      @page_title = nil
      render('home')
      @portfolios = Portfolio.paginate(page: params[:page], per_page: 15).order('created_at DESC')
    else
      @page_title = current_page.titleize
      @copy = PageAsset.content_for(current_page)
      render(current_page.underscore)
    end

  end

  protected

  def current_page
    params[:name].to_s.downcase
  end

  def ensure_valid
    valid_pages = ['home', 'contact', 'terms', 'subscribe', 'unsubscribe']
    unless valid_pages.include?(current_page)
      render_404 and return
    end
  end
end

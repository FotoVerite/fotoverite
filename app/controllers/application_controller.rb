class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include SessionMethods
  ::BRAND = ::COMPANY ='FotoVerite'
  protect_from_forgery with: :exception

  protected

  def confirm_staff_login
    unless admin_logged_in?
      session[:staff_desired_url] = url_for(params)
      flash[:notice] = "Please log in."
      redirect_to(staff_login_path) and return false
    end
    return true
  end

  # TODO: this should probably use admin_logged_in? like confirm_staff_login does
  def confirm_not_logged_in
    if session[:admin_id]
      flash[:notice] = "You are already logged in"
      redirect_to staff_root_path
    end
    return true
  end

  def confirm_member_in_good_standing
    return unless confirm_member_logged_in
    unless @current_member.good_standing?
      respond_to do |format|
        format.html {
          flash[:notice] = "Your account is not in good standing"
          redirect_to(settings_account_path) and return false
        }
        format.json {
          render(:json => {:result => "Your account is not in good standing"}) and return false
        }
      end
    else
      return true
    end
  end

  # deprecated, use "redirect_to desired_url()" instead
  def redirect_to_desired_url(fallback_url=nil, options={})
    redirect_to desired_url(fallback_url, options)
  end

  def desired_url(fallback_url=nil, options={})
    fallback_url ||= {:action => 'index'}
    key = options[:key] || :desired_url
    if session[key]
      url = session[key]
      session[key] = nil
    else
      url = fallback_url
    end
    url
  end
end

class Staff::AccessController < StaffController

  skip_before_filter :confirm_staff_login, :only => [:new, :create, :forgot_password, :send_new_password, :get_password_idea]

  def show
    render('menu')
  end

  def menu
    # just text
  end

  def cms_menu
    # just text
  end

  def image_bank
    # just text
  end

  def don_data
    # just text
  end

  def new
    @hide_navigation = true
    # Don't remember referrer for staff area, only in member areas
    session[:referrer_url] = nil
    # display login form
  end

  def create
    logout_admin_keeping_session!
    admin = Admin.authenticate(params['username'], params['password'])
    if admin && admin.enabled?
      self.current_admin = admin
      handle_remember_cookie!(admin, params[:remember_me] == "1")
      flash[:notice] = "You are now logged in."
      redirect_to desired_url(menu_staff_access_path)
    elsif admin && !admin.enabled?
      @hide_navigation = true
      flash[:error] = "Your account has been disabled."
      render('new')
    else
      @hide_navigation = true
      flash[:error]= "Username/password combination not found. Please try again."
      render('new')
    end
  end

  def destroy
    logout_admin_keeping_session!
    flash[:notice] = "You are now logged out."
    redirect_to(new_staff_access_path)
  end

  def forgot_password
    @hide_navigation = true
    # display form
  end

  def send_new_password
    @user = Admin.where(:username=> params[:username], :enabled => true).first
    if @user
      password = get_nice_password
      @user.delay.email_new_password(password)
      @user.update_attributes({:password => password})
      flash[:notice] = "New password sent to account's designated email"
      redirect_to(new_staff_access_path)
    else
      @hide_navigation = true
      flash[:notice] = "Username not found"
      render("forgot_password")
    end
  end

  def get_password_idea
    render(:text => get_nice_password)
  end

end

class Staff::AdminsController < StaffController

  def index
    @admins = Admin.paginate(:page => params[:page], :per_page => 15)
  end

  def new
    @admin = Admin.new
    @password_idea = get_nice_password
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      flash[:notice] = "Admin was successfully created."
      redirect_to staff_admins_path
    else
      @password_idea = get_nice_password
      render('new')
    end
  end

  def edit
    @admin = Admin.find(params[:id])
    @password_idea = get_nice_password
  end

  # standard edit action
  # also updates @admin.permissons.
  def update
    @admin = Admin.find(params[:id])
    # Only values that are in protected_controllers are valid
    params[:permissions] ||= []  # initialize if user submits no changes
    new_permissions = params[:permissions] & Permission.protected_controllers
    # prevent the admin from locking themselves out
    if session[:admin_id].to_i == @admin.id && !new_permissions.include?('staff/admins')
      # NB: you MUST add this back in since the form also disables the checkbox
      new_permissions << 'staff/admins'
    end
    if @admin.update_attributes(admin_params)
      @admin.update_permissions(new_permissions)
      flash[:notice] = "Admin was successfully updated."
      redirect_to staff_admins_path
    else
      @password_idea = get_nice_password
      render('edit')
    end
  end

  def delete
    @admin = Admin.find(params[:id])
  end

  def destroy
    Admin.find(params[:id]).destroy
    flash[:notice] = "Admin was successfully deleted."
    redirect_to staff_admins_path
  end

  private

  def admin_params
    params.require(:admin).permit(
      "email",
      "first_name",
      "last_name",
      "password",
      "username",
      "previous_password",
      "email_confirmation",
      "password_confirmation"
    )
  end

end

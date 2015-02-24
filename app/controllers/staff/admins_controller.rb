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
    if @admin.update_attributes(admin_params)
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

  def get_nice_password
    NicePassword.new(:length => 12, :words => 2, :digits => 2)
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

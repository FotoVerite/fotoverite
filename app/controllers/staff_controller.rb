# StaffController inherits from ApplicationController
# It contains methods common to all staff area controllers.
#
# All staff area controllers should inherit from StaffController
# and NOT from Application Controller.
#
class StaffController < ApplicationController

  layout 'staff'

  before_filter :confirm_staff_login

end

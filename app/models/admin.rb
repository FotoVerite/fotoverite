# == Schema Information
#
# Table name: admins
#
#  id                        :integer          not null, primary key
#  first_name                :string(50)
#  last_name                 :string(50)
#  username                  :string
#  email                     :string
#  hashed_password           :string           default(""), not null
#  enabled                   :boolean          default("t")
#  remember_token            :string(40)
#  remember_token_expires_at :datetime
#  created_at                :datetime
#  updated_at                :datetime
#

require 'bcrypt'
class Admin < ActiveRecord::Base
  include BCrypt
  include SessionMethodIncludes

  attr_accessor :password, :previous_password

  has_many :permissions

  validates :first_name,  :length => {:within => 2..50}
  validates :last_name,  :length => {:within => 2..50}

  validates :username,
    :length => {:within => 6..25},
    :format => {:with => /\A([a-z0-9_]+)\Z/i},
    :uniqueness => { :case_sensitive => false, :message => "already exists. Please try again." }

  validates :password,
    :length => {:within => 8..25},
    :confirmation => true,
    :on => :create

  validates :password,
    :length => {:within => 8..25},
    :confirmation => true,
    :on => :update,
    :allow_blank => true

  validates :email,
    :uniqueness => {:message => "already has an account associated with it.", :case_sensitive => false},
    :format => {:with => STANDARD_EMAIL_REGEX, :message => "is an invalid address"},
    :confirmation => {:if => :email_changed? },
    :length => {:within => 2..255}

  validates :email_confirmation, :presence => true,  :on => :update, :if => :email_changed?
  # validate anytime form params include :password or :email_confirmation
  # i.e. if you send :password, you must send :previous_password
  # You can update :email w/o it as long as :email_confirmation is nil
  validates :previous_password, :auto_password => true, :on => :update

  default_scope lambda { order("admins.last_name ASC, admins.first_name ASC") }

  before_create :create_hashed_password
  before_update :update_hashed_password
  after_save :sanitize_object

  def self.authenticate(username="", password="")
    user = Admin.find_by_username(username)
    return (user && user.is_authenticated?(password)) ? user : false
  end

  def is_authenticated?(password="")
    # Must be in this order because BCrypt::Password
    # uses a special :== method
    authentication_password == password
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  # takes controller name as parameter
  # and returns T/F if there is any permission found
  def permission_for?(controller)
    permissions.where(:controller => controller).present?
  end

  # <tt>update_permissions</tt> takes an array of permissions
  # (i.e. controller names) and then adds and removes entries
  # in the permissions table to match the new permissions.
  def update_permissions(new_permissions)
    new_permissions ||= []
    existing_permissons = permissions.map(&:controller)
    # determine what changed
    added = new_permissions - existing_permissons
    removed = existing_permissons - new_permissions
    # add/remove permissions
    added.each {|perm| permissions.create(:controller => perm) }
    permissions.where(:controller => removed).delete_all
  end

  # TODO This could be made into a proper validation
  def try_to_reset_password(new_password, reconfirm_password)
    if new_password != reconfirm_password
      errors[:base] << "The two new password fields do not match. Please try again."
    elsif new_password.blank?
      errors[:base] << "Your password cannot be left blank."
    elsif new_password.size < 6 || new_password.size > 25
      errors[:base] << "Your must be between 6 and 25 characters"
    end
    if errors.count == 0 && self.update_attributes!(:password => new_password, :password_confirmation => new_password)
      return true
    else
      return false
    end
  end

  def email_new_password(password='')
    return false if email.blank?
    PostOffice.email_new_staff_password(self, password).deliver_later
  end

  # Keep this method public and as a class method because it is called by
  # methods contained in session_method_includes.rb
  def self.create_token(string="")
    Digest::SHA1.hexdigest("Take their name #{string} and #{Time.now}")
  end

  # Keep this method public because it is called by AutoPasswordValidator
  def authentication_password
    BCrypt::Password.new(hashed_password)
  end

  private

  def sanitize_object
    self.password = nil
    self.password_confirmation = nil
    self.email_confirmation = nil
  end

  def create_hashed_password
    self.hashed_password = BCrypt::Password.create(password)
  end

  def update_hashed_password
    unless password.blank?
      self.hashed_password = BCrypt::Password.create(password)
    end
  end
end

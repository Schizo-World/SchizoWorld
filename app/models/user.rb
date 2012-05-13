require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :announces, :foreign_key => "author_id"
  has_many :announce_candidates, :foreign_key => "author_id"
  has_many :notifications
  has_and_belongs_to_many :notifications
  
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  set_table_name 'users'
  
  has_attached_file :avatar, :styles => { :large => "180x180#", :medium => "100x100#", :small => "50x50#", :thumb => "30x30#" }
  has_many :authorizations
  has_many :posts

  validates :login, :presence   => true,
                    :uniqueness => true,
                    :length     => { :within => 3..40 }

  validates :email, :presence   => true,
                    :uniqueness => true,
                    :format     => { :with => Authentication.email_regex, :message => Authentication.bad_email_message },
                    :length     => { :within => 6..100 }

  
  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation, :location, :status, :links, :url_img, :avatar


  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  def add_provider(auth_hash)
    # Check if the provider already exists, so we don't add it twice
    unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    end
  end

  protected
  
  has_many :project_users
  has_many :projects, :through => :project_users
  
  has_many :job_users
  has_many :jobs, :through => :job_users

  def self.search(search)
    if search
      find(:all, :conditions => ['login LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

end

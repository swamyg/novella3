require 'digest/sha1'
class User < ActiveRecord::Base
  has_many :novels
  has_many :chapters
  has_one :profile
  has_many :permissions
  
  named_scope :find_by_id_or_login, lambda { |id_or_login|
    { :conditions => ["id = ? OR login = ?", id_or_login, id_or_login]}   
  }
  # Virtual attribute for the unencrypted password
  attr_accessor :password

  validates_presence_of     :login, :email
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :login,    :within => 3..40
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :login, :email, :case_sensitive => false
  before_save :encrypt_password

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find_by_login(login) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    self.remember_token_expires_at = 2.weeks.from_now.utc
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  #roles & permissions methods

  def is_author?(novel)
    Permission.where(:user_id => self.id, :novel_id => novel.id, :role => 'author').present?
  end

  def is_editor?(novel)
    Permission.where(:user_id => self.id, :novel_id => novel.id, :role => 'editor').present?
  end

  def is_contributor?(novel)
    Permission.where(:user_id => self.id, :novel_id => novel.id, :role => 'contributor').present?
  end

  def is_moderator?
    Permission.where(:user_id => self.id, :role => 'moderator').present?
  end

  protected
    # before filter 
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
      self.crypted_password = encrypt(password)
    end
    
    def password_required?
      crypted_password.blank? || !password.blank?
    end
end

class User < ActiveRecord::Base
  acts_as_voter
  has_many :reports, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :authentications, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :validatable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_presence_of :name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_presence_of :password, :if => :password_required?
  validates_presence_of :password_confirmation, :if => :password_required?
  validates_uniqueness_of :email, :if => :is_not_anonym?
  validates_format_of :email, :with => EMAIL_REGEX
  validates_confirmation_of :password
  validates_numericality_of :phone, :allow_blank => true
  validates_length_of :phone, :within => 6..20, :allow_blank => true

  def full_name
    name + " " + last_name
  end

  def apply_omniauth(auth)
    if auth["provider"] == "twitter"
      credentials    = auth["user_info"]["name"].split(' ')
      self.name      = credentials[0]
      self.last_name = credentials[1]
      self.authentications.build(:provider => auth["provider"], :uid => auth["uid"])
    else
      self.name      = auth["user_info"]["first_name"]
      self.last_name = auth["user_info"]["last_name"]
      self.email     = auth["extra"]["user_hash"]["email"]
      self.authentications.build(:provider => auth["provider"], :uid => auth["uid"])
    end
  end

  def is_not_blank?
    !self.phone.blank?
  end

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :last_name, :email, :phone, :password, :password_confirmation, :remember_me, :is_admin, :is_anonym

  def is_not_anonym?
    user = User.where(:email => self.email)
    if user
      if user.where(:is_anonym => false).count > 0
        true
      elsif user.where(:is_anonym => nil).count > 0
        true
      else
       false
      end
    end
  end

  def password_required?
    self.authentications.empty? && !self.is_anonym
  end

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :last_name, :email, :phone, :password, :password_confirmation, :remember_me, :is_admin, :is_anonym

  protected
  def self.find_for_authentication(conditions={})
    conditions[:is_anonym] = false
    super
  end

end

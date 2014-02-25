class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable,:confirmable, :validatable
  has_many :venues,:dependent => :destroy
  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  field :unconfirmed_email,    :type => String # Only if using reconfirmable
   
  ## extra field
  field :first_name, :type => String
  field :last_name, :type => String
  field :username, :type => String
  field :uid, :type => String
  field :provider, :type => String
  field :status,:type => Boolean,:default => false
  field :role,:type => String,:default => "user"
  
  validates :first_name,:last_name,:username,:presence => true

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time
  
  def self.create_from_omniauth(auth)
    user = User.where(:uid => auth["uid"]).first
    if user == nil
      user = User.new(:first_name => auth["extra"]["raw_info"]["first_name"],:last_name => auth["extra"]["raw_info"]["last_name"],:username => auth["extra"]["raw_info"]["username"])
      user.email = auth["extra"]["raw_info"]["email"]
      user.uid = auth["uid"]
      user.provider = auth["provider"]
      #      user.confirmed_at = Time.now
      #      user.confirmation_token = nil
      user.save(:validate => false)
      user.confirm!
    end
    return user
  end
end

class User < ActiveRecord::Base
  attr_reader :password

  validates :email, :password_digest, :session_token, presence: true
  validates :email, uniqueness: true
  validates :password, length: {minimum:6, allow_nil:true}

  after_initialize :ensure_session_token

  has_many :notes

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save
  end

  def self.find_by_credentials(email,password)
    user = self.find_by(email:email)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

end

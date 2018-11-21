class User < ApplicationRecord
  validates :password_digest, :username, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  attr_reader :password

  after_initialize :ensure_token

  has_many :subs,
    foreign_key: :moderator_id,
    class_name: :Sub

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ensure_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def reset_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return user if user && user.is_password?(password)
    nil
  end


end

class User < ApplicationRecord
    before_validation :ensure_session_token
    
    validates :username, :password_digest, :session_token, presence: true
    validates :username, :session_token, uniqueness: true
    validates :password, length: { minimum: 6, allow_nil: true }
    # after_initialize :ensure_session_token

    has_many :subs, 
        foreign_key: :moderator_id,
        class_name: :Sub

    attr_reader :password

    def self.find_by_credentials(username, password)
        @user = User.find_by(username: username)
        return nil if @user.nil?
        @user.is_password?(password) ? @user : nil
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end    

    def password=(password)
        @password = password 
        self.password_digest = BCrypt::Password.create(password)
    end

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save! 
        self.session_token
    end
end

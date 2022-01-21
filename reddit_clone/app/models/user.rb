class User < ApplicationRecord
    validates :username, :password_digest, :session_token, presence: true
    validates :username, :session_token, uniqueness: true
    validates :password, length: { minimum: 6, allow_nil: true }

    attr_reader :password

    def self.find_by_credentials(username, password)
        @user = User.find(username: username)
        return nil if @user.nil?
        @user.is_password?(password)
    end

    
end

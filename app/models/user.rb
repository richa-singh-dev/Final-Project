class User < ApplicationRecord
    has_many :articles
    has_secure_password
    validates :email, presence: true, uniqueness: {case_sensitive: false}
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end

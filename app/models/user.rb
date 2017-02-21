class User < ApplicationRecord
	before_save {self.email = self.email.downcase}

	# email regex validation
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name, presence: true, length: {maximum: 40}
	validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

	# add password to the user validation
	has_secure_password
	validates :password, presence: true, length: {minimum: 6}
end

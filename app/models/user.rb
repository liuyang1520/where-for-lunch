class User < ApplicationRecord
	attr_accessor :remember_token, :activation_token
	before_create :create_activation_digest

	before_save {self.email = self.email.downcase}

	# email regex validation
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name, presence: true, length: {maximum: 40}
	validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

	# add password to the user validation
	has_secure_password
	validates :password, presence: true, length: {minimum: 6}, allow_nil: true

	def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

	def self.get_token
		SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token = User.get_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def authenticated?(attribute, token)
		digest = self.send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	private
		def create_activation_digest
			self.activation_token = User.get_token
			self.activation_digest = User.digest(activation_token)
		end
end

class User < ApplicationRecord
	attr_accessor :remember_token
	before_save :downcase_email
	validates :password, presence: true, length: {minimum: 8}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255},
					  format: { with: VALID_EMAIL_REGEX},
					  uniqueness: {case_sensitive: false}
	validates :name, presence: true, length: {maximum: 60}, uniqueness: true
	has_secure_password

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
													  BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)													  
	end

	private

	def downcase_email
		email.downcase!
	end
end
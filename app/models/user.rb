class User < ApplicationRecord
	before_save :downcase_email
	validates :password, presence: true, length: {minimum: 8}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255},
					  format: { with: VALID_EMAIL_REGEX},
					  uniqueness: {case_sensitive: false}
	validates :name, presence: true, length: {maximum: 60}, uniqueness: true
	has_secure_password

	def downcase_email
		email.downcase!
	end
end

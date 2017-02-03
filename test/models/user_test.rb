require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
  	@user = User.new(name: "Example User", email: "user@example.com", password: "password", password_confirmation: "password")
  end

  test "user should be valid" do
  	assert @user.valid?
  end

  test "name can't be blank" do
  	@user.name = ''
  	assert_not @user.valid?
  end

  test "name can't be more than 60 chars" do
  	@user.name = "a" * 61
  	assert_not @user.valid?
  end

  test "name has to be unique" do
  	@double = @user.dup
  	@user.save
  	assert_not @double.valid?
  end

  test "email must be valid" do
  	bad_emails = %w[me@me me@medotcom meatme.com me@me.com.]
  	bad_emails.each do |email|
  		@user.email = email
  		assert_not @user.valid?, "#{email} should not be valid"
  	end
  end

  test "email can't be blank" do
  	@user.email = ""
  	assert_not @user.valid?
  end

  test "email can't be longer than 255 chars" do
  	@user.email = "a"*255 + "@example.com"
  	assert_not @user.valid?
  end

  test "email should be all lowercase" do
  	mixed_case_email = "UsEr@ExAmPlE.CoM"
  	@user.email = mixed_case_email
  	@user.save
  	assert_equal mixed_case_email.downcase, @user.email
  end

  test "password can't be empty" do
  	@user.password = @user.password_confirmation = "" * 8
  	assert_not @user.valid?
  end

  test "password can't be less than 8 chars" do
  	@user.password = "a"*7
  	assert_not @user.valid?
  end

end

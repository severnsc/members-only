require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:chris)
	end

	test "Try to login with invalid login information then valid" do
		get login_path
		assert_template 'sessions/new'
		#Correct Email, wrong password
		post login_path, params: { session: { email: @user.email,
											  password: "foobar"}}
		assert_template 'new'
		assert_not flash.empty?
		#Wrong email, correct password
		post login_path, params: { session: { email: "me@example.com",
											  password: "password"}}
		assert_template 'new'
		assert_not flash.empty?
		#Correct email and password
		post login_path, params: { session: { email: @user.email,
											  password: "password"}}
		assert is_logged_in?
		assert_redirected_to @user
		follow_redirect!
		assert_template 'users/show'
	end

	test "that the flash only displays on the login page after bad login attempt" do
		get login_path
		assert_template 'sessions/new'
		post login_path, params: { session: { email: "",
											  password: ""}}
		assert_not flash.empty?
		assert_template 'sessions/new'
		get signup_path
		assert flash.empty?
	end

	test "logout user" do
		log_in_as(@user)
		delete logout_path
		assert_redirected_to login_url
		follow_redirect!
		assert_template 'sessions/new'
	end
end
require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:chris)
	end
  
  test "should get new" do
  	get signup_path
  	assert_response :success
  end

  test "should redirect show when not logged in" do
  	get user_path(@user)
  	assert_redirected_to login_url
  	log_in_as(@user)
  	get user_path(@user)
  	assert_response :success
  	assert_template 'users/show'
  end

end
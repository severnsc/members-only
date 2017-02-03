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
  	assert_redirected_to user_path(@user)
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
    assert_not flash.empty?
    log_in_as(@user)
    assert_redirected_to users_path
  end

end
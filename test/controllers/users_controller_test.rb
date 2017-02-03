require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:chris)
    @other_user = users(:archer)
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

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_redirected_to login_url
    assert_not flash.empty?
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
  end

  test "user can only see their own edit page" do
    log_in_as(@user)
    get edit_user_path(@other_user)
    assert_redirected_to user_path(@user)
    get edit_user_path(@user)
  end

  test "redirect delete if not logged in" do
    delete user_path(@user)
    assert_redirected_to login_url
  end

  test "redirect delete if not admin" do
    log_in_as(@other_user)
    delete user_path(@user)
    assert_redirected_to root_url
  end

end
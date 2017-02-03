require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  test "gets new" do
  	get login_path
  	assert_response :success
  end
end

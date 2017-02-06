require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:chris)
  end

  test "should redirect new if not logged in" do
    get new_post_path
    assert_redirected_to login_path
    log_in_as(@user)
    get new_post_path
    assert_template 'posts/new'
  end

  test "should redirect create if not logged in" do
    post posts_path, params: { post:{ body: "This is some text",
                                      user_id: @user.id}}
    assert_redirected_to login_path
  end

end

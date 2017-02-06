require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  def setup
  	@user = users(:chris)
  	@post = Post.new(body: "This is a post", user_id: @user.id)
  end

  test "post should be valid" do
  	assert @post.valid?
  end

  test "body should be present" do
  	@post.body = "   "
  	assert_not @post.valid?
  end

  test "body should be 255 chars max" do
  	@post.body = "a"*256
  	assert_not @post.valid?
  end

  test "user_id should be present" do
  	@post.user_id = " "
  	assert_not @post.valid?
  end
end

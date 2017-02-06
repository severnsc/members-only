require 'test_helper'

class PostsIndexTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:chris)
	end

	test "when not logged in posts index shouldn't show post authors" do
		get posts_path
		assert_template 'posts/index'
		assert_select 'div.user_post'
		assert_select 'h3', count:0
	end

	test "when logged in posts index shows post authors" do
		log_in_as(@user)
		get posts_path
		assert_template 'posts/index'
		assert_select 'div.user_post'
		assert_select 'h3'
	end
end
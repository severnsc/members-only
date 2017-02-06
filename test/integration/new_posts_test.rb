require 'test_helper'

class NewPostsTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:chris)
	end

	test "only logged in users should see the new post page" do
		get new_post_path
		assert_redirected_to login_path
		log_in_as(@user)
		assert_redirected_to new_post_path
		follow_redirect!
		assert_template 'posts/new'
		assert_select 'form#new_post'
	end

	test "invalid post information, then valid" do
		log_in_as(@user)
		get new_post_path
		assert_template 'posts/new'
		#empty body
		assert_no_difference 'Post.count' do
			post posts_path, params: { post: { body: "",
																					user_id: @user.id}}
		end
		assert_select "div#error_explanation"
		assert_template 'posts/new'
		#Correct info
		assert_difference 'Post.count' do
			post posts_path, params: { post: { body: "This is some text.",
																					user_id: @user.id}}
		end
		assert_redirected_to user_path(@user)
		follow_redirect!
		assert_template 'users/show'
		assert_not flash.empty?
	end

end
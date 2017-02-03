require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest

	def setup
		@admin = users(:chris)
		@user = users(:archer)
	end

	test "only logged in users should see index page" do
		get users_path
		assert_redirected_to login_url
		log_in_as(@user)
		assert_redirected_to users_path
		follow_redirect!
		assert_template 'users/index'
		assert_select "a[href=?]", user_path(@user)
	end

	test "delete links should not appear for non-admins" do
		log_in_as(@user)
		get users_path
		assert_template 'users/index'
		assert_select "a", text: "Delete", count:0
	end

	test "delete links should appear for admins" do
		log_in_as(@admin)
		get users_path
		assert_template 'users/index'
		users = User.paginate(page: 1)
		users.each do |user|
			assert_select "a[href=?]", user_path(user), text: user.name
			unless user == @admin
				assert_select "a[href=?]", user_path(user), text: "Delete"
			end
		end
	end
end
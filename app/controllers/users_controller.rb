class UsersController < ApplicationController
	before_action :logged_in_user, only: [:show, :index]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			log_in(@user)
			flash[:success] = "Welcome to Members Only!"
			redirect_to user_path(@user)
		else
			render 'new'
		end
	end

	def show
		@user = User.find_by(id: params[:id])
	end

	def index
		@users = User.all
	end

	private

	def logged_in_user
		unless logged_in?
			store_location
			flash[:danger] = "Please log in"
			redirect_to login_url
		end
	end

	def user_params
		params.require(:user).permit(:email, :name, :password, :password_confirmation)
	end
end

class UsersController < ApplicationController
	before_action :logged_in_user, only: [:show, :index, :edit, :destroy]
	before_action :correct_user, only:[:edit]
	before_action :is_admin?, only: [:destroy]

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
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated!"
			redirect_to user_path(@user)
		else
			render 'edit'
		end
	end

	def index
		@users = User.all
	end

	def destroy
		@user = User.find(params[:id])
		@user.delete
		redirect_to users_path
	end

	private

	def logged_in_user
		unless logged_in?
			store_location
			flash[:danger] = "Please log in"
			redirect_to login_url
		end
	end

	def correct_user
		@user = User.find(params[:id])
		redirect_to current_user unless current_user?(@user)
	end

	def is_admin?
		@user = current_user
		redirect_to root_url unless @user.admin?
	end

	def user_params
		params.require(:user).permit(:email, :name, :password, :password_confirmation)
	end
end

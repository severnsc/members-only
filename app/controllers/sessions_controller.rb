class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			log_in(user)
			remember(user)
			redirect_user_or(user)
		else
			flash.now[:danger] = "Invlaid email/password combination"
			render 'new'
		end
	end

	def destroy
		user = User.find_by(id: session[:user_id])
		log_out(user)
		redirect_to login_path
	end

end

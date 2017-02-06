class PostsController < ApplicationController
	before_action :logged_in_user, only:[:new, :create]

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)
  	if @post.save
  		#if it's successful stuff
  	else
  		render 'new'
  	end
  end

  def index
  end
end

private 

	def logged_in_user
		unless logged_in?
			store_location
			flash[:danger] = "Please log in"
			redirect_to login_url
		end
	end

	def post_params
		params.require(:post).permit(:body, :user_id)
	end
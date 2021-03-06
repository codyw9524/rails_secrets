class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
	before_action :require_current_user, only: [:show, :edit, :update, :destroy]
	def create
		user = User.new(user_params)
		if user.save
			session[:user_id] = user[:id]
			redirect_to "/users/#{user[:id]}"
		else
			flash[:errors] = user.errors.full_messages
			redirect_to '/users/new'
		end
	end
	def show
		@user = User.find(params[:id])
		@secrets = @user.secrets
	end
	def new
	end
	def edit
		@user = User.find(params[:id])
	end
	def update
		user = User.find(params[:id])
		if user.update(user_params)
			redirect_to "/users/#{user[:id]}"
		else
			flash[:errors] = user.errors.full_messages
			redirect_to "/users/#{user[:id]}/edit"
		end
	end
	def destroy
		User.find(params[:id]).destroy
		redirect_to "/sessions/new"
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
end

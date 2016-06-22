class SessionsController < ApplicationController
	def new
	end
	def create
		u = User.find_by(email: params[:email])
		if u && u.authenticate(params[:password])
			session[:user_id] = u[:id]
			redirect_to "/users/#{u[:id]}"
		else
			flash[:errors] = "Invalid credentials."
			redirect_to :back
		end
	end
	def destroy
		reset_session
		redirect_to '/sessions/new'
	end
end

class LikesController < ApplicationController
	before_action :require_login, only: [:create, :destroy]
	def create
		like = Like.new(user: current_user, secret_id: params[:like][:secret_id])
		flash[:errors] = like.errors.full_messages unless like.save
		redirect_to '/secrets'
	end
	def destroy
		like = Like.find_by(user: current_user, secret_id: params[:like][:secret_id])
		like.destroy if like
		redirect_to '/secrets'
	end

	private
		def like_params
			params.require(:like).permit(:secret_id)
		end
end

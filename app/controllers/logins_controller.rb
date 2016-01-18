class LoginsController < ApplicationController
	def new
		
	end

	def create
		user = User.find_by(email: params[:email]).try(:authenticate, params[:password]) 

		if user
			session[:user_id] = user.id
			redirect_to root_path # change to profile
		else
			flash.now[:danger] = 'Внесовте погрешен емаил или лозинка!'
			render :new
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end
	
end
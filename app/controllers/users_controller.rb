class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :set_user, only: [:show, :edit, :update, :show_password, :update_password, :adverts] 
	respond_to :html, :json

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
	
		if @user.save
			flash[:success] = 'Успешно се регистриравте!'
			session[:user_id] = @user.id
			redirect_to root_path # change to articles
		else
			render :new
		end
	end

	def show
	end

	def edit
	end

	def update
		if @user.update(user_params)
			flash[:success] = 'Успешно се променети податоците'
			render :show
		else
			render :edit
		end
	end

	def show_password
	end

	def adverts
		@adverts = []
		@user.advertisements.each do |advert|
			@adverts.push({id: advert.id, title: advert.title, category: advert.category.name, city: advert.city.name, \
				price: advert.price ? "#{advert.price} денари" : "По договор", time: advert.updated_at.strftime("%d-%m-%Y %H:%M")  })
		end
		respond_with(@adverts)
	end

	def update_password
		if @user.authenticate(params[:user][:current_password])
			if @user.update_attributes(user_params)
				flash[:success] = 'Успешно ја променавте лозинката'
				redirect_to root_path
			else
				render :show_password
			end
		else
			@user.errors.add(:current_password,  'Старата лозинката е погрешна')
			render :show_password
		end
	end

	private

		def user_params
			params.require(:user).permit(:username, :email, :phone, :password, :password_confirmation)
		end

		def set_user
			@user = User.find(params[:id])
		end

end
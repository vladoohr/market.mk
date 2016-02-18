class AdvertisementsController < ApplicationController
	before_action :all_ordered_catwgories, only: [:new, :show, :edit, :search]
	before_action :require_user, except: [:index, :create, :search, :adverts]
	before_action :find_user, only: [:show, :edit, :update, :destroy]

	def index
	end

	def new
		@advertisement = Advertisement.new		
	end

	def create
		@advertisement = Advertisement.new(advertisement_params)
		@advertisement.user = current_user

		if @advertisement.save 
			flash[:success] = "Успешно внесовте оглас!"
			redirect_to root_path # to be change to user's adverts
		else
			render :new
		end
	end

	def show
	end

	def edit
	end

	def update
		if @advertisement.update(advertisement_params)
			flash[:success] = "Успешно го променавте огласот"
			redirect_to adverts_user_path(current_user)
		else
			render :edit
		end		
	end

	def destroy
		@advertisement.destroy
		redirect_to root_path # change to redirect_to user's adverts
		flash[:success ] = "Огласот е избришан!"
	end

	def search
			if params[:search] != "" or params[:category_id] != "0" or params[:city_id] != "33"
				@advertisements = Advertisement.search(params[:search], params[:category_id], params[:city_id])
			else
				@advertisements = Advertisement.all.order("updated_at DESC")
			end

			render :adverts
	end

	def adverts
	end

	private
		def advertisement_params
			params.require(:advertisement).permit(:advert_type, :state, :title, :description, :price, :latitude, :longitude, :city_id, :category_id)
		end

		def find_user
			@advertisement = Advertisement.find(params[:id])
		end

		def all_ordered_catwgories
			@categories = {}
			categories_main = Category.where(parent_id: nil)
			categories_main.each do |category|
				@categories[category.name] = {category.id => category.parent_id}
				category.children.each do |child|
					@categories[child.name] = {child.id => child.parent_id}
				end
			end
		end
	
end
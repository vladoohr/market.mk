class AdvertisementsController < ApplicationController
	before_action :all_ordered_catwgories, only: [:new, :show]

	def new
		if logged_in?
			@advertisement = Advertisement.new
		else
			flash[:danger] = "Мора да бидите логирани за да ја извршите акцијата!"
			redirect_to :back
		end
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
		@advertisement = Advertisement.find(params[:id])
	end

	def destroy
	end

	private
		def advertisement_params
			params.require(:advertisement).permit(:advert_type, :state, :title, :description, :price, :latitude, :longitude, :city_id, :category_id)
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
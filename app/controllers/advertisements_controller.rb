class AdvertisementsController < ApplicationController
	before_action :all_ordered_categories, only: [:new, :show, :edit, :search, :index]
	before_action :require_user, except: [:index, :create, :search, :adverts, :show]
	before_action :find_advert, only: [:show, :edit, :update, :destroy]

	def index
		if params[:search] != "" or params[:category_id] != "0" or params[:city_id] != "33"
				@advertisements = Advertisement.search( params[:search], params[:category_id], params[:city_id])
										                    .paginate(:page => params[:page], :per_page => 5)
																				.order("updated_at DESC")
		else
			@advertisements = Advertisement.paginate(:page => params[:page], :per_page => 5)
																			.order("updated_at DESC")
		end
		render :adverts
	end

	def new
		@advertisement = Advertisement.new		
	end

	def create
		@advertisement = current_user.advertisements.build(advertisement_params)
		# authorize @advertisement
		# @advertisement = Advertisement.new(advertisement_params)
		# @advertisement.user = current_user

		if @advertisement.save
			if params[:images]
					params[:images].each do |img|
          	@advertisement.photos.create(image: img)
          end
      end

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
		redirect_to :back
		flash[:success ] = "Огласот е избришан!"
	end

	def adverts
	end

	private
		def advertisement_params
			params.require(:advertisement).permit(:advert_type, :state, :title, :description, :price, :latitude, :longitude, :city_id, :category_id)
		end

		def find_advert
			@advertisement = Advertisement.find(params[:id])
		end

		def all_ordered_categories
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
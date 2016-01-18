class WelcomeController < ApplicationController

	def index
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

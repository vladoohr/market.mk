class Advertisement < ActiveRecord::Base
	belongs_to :user
	belongs_to :category
	belongs_to :city
	has_many :photos, :inverse_of => :advertisement, dependent: :destroy
	accepts_nested_attributes_for :photos, allow_destroy: true

	validates :advert_type, presence: {message: "Мора да одберeте тип"}
	validates :state, presence: {message: "Мора да одберeте состојба"}
	validates :title, presence: {message: "Наслов е задолжително поле"}
	validates :category, presence: {message: "Мора да одберeте категорија"}
	validates :description, presence: {message: "Мора да внесете опис"}

	def self.search(search, category, city)
		if search != ""
			where("title LIKE ?", "%#{search}%") 
  		where("description LIKE ?", "%#{search}%")
  	elsif category != "0" 
  		where("category_id = ?", "#{category}")
  	elsif city != "33"
  		where("city_id = ?", "#{city}")
		end
	end
end

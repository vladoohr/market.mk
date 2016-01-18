class Advertisement < ActiveRecord::Base
	belongs_to :user
	belongs_to :category
	belongs_to :city
	has_many :photos, dependent: :destroy
end

class AdvertisementCity < ActiveRecord::Base
	belongs_to :advertisement
	belongs_to :city
end

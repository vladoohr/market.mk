class Photo < ActiveRecord::Base
  belongs_to :advertisement
  validates :advertisement, presence: true
  validate :image_size, :if => "image?"

 	mount_uploader :image, PictureUploader
 
 	def image_size
 		if image.size > 5.megabytes
 			errors.add(:image, "Size cannot be more than 5MB")
 		end
 	end

end

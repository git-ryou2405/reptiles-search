class Reptile < ApplicationRecord
  belongs_to :user
  mount_uploaders :images, ImageUploader
  mount_uploader :reptile_img1, ImageUploader
  mount_uploader :reptile_img2, ImageUploader
  mount_uploader :reptile_img3, ImageUploader
  serialize :images, JSON
end

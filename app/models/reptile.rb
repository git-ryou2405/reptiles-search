class Reptile < ApplicationRecord
  belongs_to :user
  mount_uploaders :images, ImageUploader
  serialize :images, JSON
end

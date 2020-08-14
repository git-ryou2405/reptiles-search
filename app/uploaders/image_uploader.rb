class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  
  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # アップロードファイルの保存先
  def store_dir
    Rails.application.config.another_logger.debug("[d] Image_uploader.rb  ac: store_dir")
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # JPEG 形式に変換して保存
  # process convert: "jpg"
  
  # リサイズ設定
  # process resize_to_fit: [300, 200]
  # process resize_to_fill: [300, 200, "Center"]
  process resize_and_pad: [400, 300, "#fff", "Center"]
  
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # 拡張子 jpg jpeg gif png のみ許可
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # ファイル名は original.jpg で保存 (jpeg変換しているので拡張子は固定)
  # def filename
  #   "original.jpg" if original_filename
  # end
end

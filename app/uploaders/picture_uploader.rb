class PictureUploader < CarrierWave::Uploader::Base
include CarrierWave::MiniMagick
  process resize_to_limit: [555, 555]

  if Rails.env.production?
    cache_dir :fog
  else
    cache_dir :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "/assets/" + [version_name, "default.png"].compact.join('_')
  end

  version :thumb do
    process resize_to_fill: [300,400]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end
end

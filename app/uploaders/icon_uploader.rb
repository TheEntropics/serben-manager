class IconUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def store_dir
    'icons'
  end

  def default_url
    "/default_icon.png"
  end

  process :resize_to_fit => [200, 200]

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end

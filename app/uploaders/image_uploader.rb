class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  # アップローダーを選択する。
  # storage :file
  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  %w(jpg jpeg gif png)

end

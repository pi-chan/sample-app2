# encoding: utf-8

class DiaryImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.user_id}"
  end

  if Rails.env.test?
    def cache_dir
      "#{Rails.root}/spec/support/uploads/tmp"
    end 
    def store_dir
      "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end  

  process :convert => 'jpg'

  process :resize_to_limit => [600, 600]

  # Create different versions of your uploaded files:
  version :medium do
    process :resize_to_fit => [128, 128]
  end

  version :small do
    process :resize_to_fit => [50, 50]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end
  
  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end  
  
end

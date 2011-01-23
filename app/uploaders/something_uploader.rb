# encoding: utf-8

class SomethingUploader < CarrierWave::Uploader::Base
  # Include RMagick or ImageScience support:
  include CarrierWave::RMagick
  # include CarrierWave::ImageScience

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :s3

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
  
  def add_shoelaces
    which_shoelace = self.model.shoelace.to_i
    unless which_shoelace.between?(1,4)
      which_shoelace = rand(4) + 1
    end
    shoelace = Magick::Image.read(Rails.root.join('public', 'images', 'shoelaces', "#{which_shoelace}.png"))[0]
    manipulate! do |img|
      img.composite! shoelace, Magick::CenterGravity, Magick::AtopCompositeOp
    end
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
   #process :add_shoelaces
    process :add_shoelaces
    process :resize_to_limit => [900,9999]
    process :convert => 'png'



   version :thumb do
     process :add_shoelaces
     process :resize_to_fill => [255,255]
     process :convert => 'png'
   end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
   def extension_white_list
     %w(jpg jpeg gif png)
   end

  # Override the filename of the uploaded files:
  def filename
     super.gsub(/\.(?:gif|png|jpg|jpeg)$/, '') + ".png"
  end

end

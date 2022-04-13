class IllustrationUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :fog
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
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
  version :thumb do
    process resize_to_fit: [300, 300]
    # process :watermark
  end

  def watermark
    image = MiniMagick::Image.open(file.path)
    logo = MiniMagick::Image.open(Rails.root.join("app", "assets", "images", "watermark.png"))

    manipulate! do |img|
      result = img.composite(logo) do |c|
        c.gravity "center"
      end
      result
    end
    # result write ''
    # mark.background_color = "none"

    # manipulate! do |image|
    #   tile = Magick::ImageList.new
    #   page = Magick::Rectangle.new(0, 0, 0, 0)

    #   (image.columns / mark.columns.to_f).ceil.times do |x|
    #     (image.rows / mark.rows.to_f).ceil.times do |y|
    #       tile << mark.dup
    #       page.x = x * tile.columns
    #       page.y = y * tile.rows
    #       tile.page = page
    #     end
    #   end

    #   image.composite(tile.mosaic, 0, 0, Magick::OverCompositeOp)
    # end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    original_filename if original_filename
  end
end

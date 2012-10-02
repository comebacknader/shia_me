module Paperclip
  class Cropper < Thumbnail
    def initialize(file, options = {}, attachment = nil)
      super
      @current_geometry.width  = target.crop_width
      @current_geometry.height = target.crop_height
    end
    def target
      @attachment.instance
    end
    def transformation_command
      crop_command = [
        "-crop",
        "#{target.crop_width}x" \
          "#{target.crop_height}+" \
          "#{target.crop_x}+" \
          "#{target.crop_y}",
        "+repage"
      ]
      crop_command + super
    end
  end
end
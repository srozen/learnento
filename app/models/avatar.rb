class Avatar

  def self.base64_to_imagefile(data, filename)
    decoded_file = Base64.decode64(data.gsub(/^data:image\/(png|jpeg|gif);base64,/,''))
    tempfile = Tempfile.new(['image','.jpg'])
    tempfile.binmode
    tempfile.write decoded_file
    ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile, :filename => filename, :original_filename => filename)
  end
end
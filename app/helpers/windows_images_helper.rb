require 'zip'

module WindowsImagesHelper
  def extract_zip_to(zip, directory)
    Zip::File.open(zip) do |zip_file|
      zip_file.each do |entry|
        entry.extract("#{directory}/#{entry.name}")
      end
    end
  end
end

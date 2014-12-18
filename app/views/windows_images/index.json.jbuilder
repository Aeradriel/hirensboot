json.array!(@windows_images) do |windows_image|
  json.extract! windows_image, :id
  json.url windows_image_url(windows_image, format: :json)
end

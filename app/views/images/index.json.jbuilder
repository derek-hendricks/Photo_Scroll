json.array!(@images) do |image|
  json.extract! image, :id, :caption, :description, :url, :rating
  json.url image_url(image, format: :json)
end

json.array!(@authors) do |author|
  json.extract! author, :id, :full_name, :username, :password, :profile, :image
  json.url author_url(author, format: :json)
end

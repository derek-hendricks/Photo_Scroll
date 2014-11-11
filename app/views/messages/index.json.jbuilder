json.array!(@messages) do |message|
  json.extract! message, :id, :contents
  json.url message_url(message, format: :json)
end
